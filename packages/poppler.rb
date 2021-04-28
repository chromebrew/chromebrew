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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/21.04.0-1_armv7l/poppler-21.04.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/21.04.0-1_armv7l/poppler-21.04.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/21.04.0-1_i686/poppler-21.04.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/21.04.0-1_x86_64/poppler-21.04.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4ee2c4b1b30d7a39d18dd6b3b5b45f284c730cf83d7f46cabd6ba4a64e518f4f',
     armv7l: '4ee2c4b1b30d7a39d18dd6b3b5b45f284c730cf83d7f46cabd6ba4a64e518f4f',
       i686: '3921cca2f9d5da0d24263bb6297f77027230fa36dd434e216d4d6fef3b2c14cc',
     x86_64: 'f44903cd9abb9a0c58ef0f9554f5f877752cfbbc701620b1a81ef7c71e049b93'
  })

  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'glib'
  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'nspr'
  depends_on 'nss'
  depends_on 'openjpeg'
  depends_on 'qtbase'

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
