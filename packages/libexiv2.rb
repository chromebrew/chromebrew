require 'package'

class Libexiv2 < Package
  description 'Exiv2 is a Cross-platform C++ library and a command line utility to manage image metadata.'
  homepage 'http://exiv2.org/'
  @_ver = '0.27.3-d8dd'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/Exiv2/exiv2/archive/d8dd632ad511db37245e4fe644a3cd399d770399.zip'
  source_sha256 '4cf76787b665186c7a484f16aaf92b306be3fa34feb1edbda79442811dd4287e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libexiv2-0.27.3-d8dd-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libexiv2-0.27.3-d8dd-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libexiv2-0.27.3-d8dd-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libexiv2-0.27.3-d8dd-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd5e464080d02bd02f92cc8faab43eae4ed3f65a86dd931302e9d3400df65ece1',
     armv7l: 'd5e464080d02bd02f92cc8faab43eae4ed3f65a86dd931302e9d3400df65ece1',
       i686: '182b35e673f39fc2288839ce36df148ecf646ed3aa239992001abf224c5e91e1',
     x86_64: 'f538547a42943c62fbdc847a17ffb38304ffda35648116477885e661fcefd2f4'
  })

  depends_on 'libssh'
  depends_on 'ccache' => :build

  def self.patch
    system "sed -i 's/MINGW OR CYGWIN OR CMAKE_HOST_SOLARIS/UNIX/g' cmake/compilerFlags.cmake"
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
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
