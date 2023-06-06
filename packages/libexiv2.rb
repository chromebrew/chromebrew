require 'package'

class Libexiv2 < Package
  description 'Exiv2 is a Cross-platform C++ library and a command line utility to manage image metadata.'
  homepage 'http://exiv2.org/'
  @_ver = '0.27.5'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Exiv2/exiv2/archive/refs/tags/v0.27.5.tar.gz'
  source_sha256 '1da1721f84809e4d37b3f106adb18b70b1b0441c860746ce6812bb3df184ed6c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libexiv2/0.27.5_armv7l/libexiv2-0.27.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libexiv2/0.27.5_armv7l/libexiv2-0.27.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libexiv2/0.27.5_i686/libexiv2-0.27.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libexiv2/0.27.5_x86_64/libexiv2-0.27.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '12707819474aa94f34f38d2b81ac4ab8d94e79868ce31c4b6c56ba5ad0690a2a',
     armv7l: '12707819474aa94f34f38d2b81ac4ab8d94e79868ce31c4b6c56ba5ad0690a2a',
       i686: 'c33dc88fbb67b7d2adc32b5cb01cce8cec7c0db0d92f3ef1ee2ae90adc717514',
     x86_64: '67103e8c19401e0c0a944e50856f3a40c41846e29dbfae84ef273af8134445c6'
  })

  depends_on 'libssh'
  # depends_on 'ccache' => :build
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'curl' # R
  depends_on 'zlibpkg' # R

  def self.patch
    system "sed -i 's/MINGW OR CYGWIN OR CMAKE_HOST_SOLARIS/UNIX/g' cmake/compilerFlags.cmake"
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
      -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DEXIV2_ENABLE_CURL=ON \
      -DEXIV2_ENABLE_SSH=ON \
      -DEXIV2_ENABLE_WEBREADY=ON \
      -DEXIV2_ENABLE_VIDEO=ON \
      -DBUILD_WITH_CCACHE=ON \
      .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
