require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  @_ver = '21.04.0'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://poppler.freedesktop.org/poppler-#{@_ver}.tar.xz"
  source_sha256 '5e2219656c6bbd36154133fef2e12b7d0938464518827098b29a10b1697ea79c'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.04.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.04.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.04.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.04.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4ee2c4b1b30d7a39d18dd6b3b5b45f284c730cf83d7f46cabd6ba4a64e518f4f',
     armv7l: '4ee2c4b1b30d7a39d18dd6b3b5b45f284c730cf83d7f46cabd6ba4a64e518f4f',
       i686: '3921cca2f9d5da0d24263bb6297f77027230fa36dd434e216d4d6fef3b2c14cc',
     x86_64: 'f44903cd9abb9a0c58ef0f9554f5f877752cfbbc701620b1a81ef7c71e049b93'
  })

  depends_on 'boost'
  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freeglut'
  depends_on 'freetype'
  depends_on 'glib'
  depends_on 'graphite'
  depends_on 'harfbuzz'
  depends_on 'lcms'
  depends_on 'libdeflate'
  depends_on 'libdrm'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libunwind'
  depends_on 'libwebp'
  depends_on 'libx11'
  depends_on 'libxau'
  depends_on 'libxcb'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxshmfence'
  depends_on 'libxxf86vm'
  depends_on 'mesa'
  depends_on 'nspr'
  depends_on 'nss'
  depends_on 'openjpeg'
  depends_on 'pcre'
  depends_on 'pixman'
  depends_on 'poppler_data'
  depends_on 'qtbase'
  depends_on 'qttools'
  depends_on 'util_linux'
  depends_on 'wayland'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      CFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto -L#{CREW_LIB_PREFIX}' \
      cmake #{CREW_CMAKE_OPTIONS} .. -G Ninja \
      -DCMAKE_CXX_FLAGS='-pipe -flto=auto -std=c++11 \
      -I#{CREW_PREFIX}/include/GL -I#{CREW_PREFIX}/include/openjpeg-2.4 \
      -I#{CREW_PREFIX}/include' \
      -DENABLE_UNSTABLE_API_ABI_HEADERS=on"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
