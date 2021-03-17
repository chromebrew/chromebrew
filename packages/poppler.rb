require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  @_ver = '21.03.0'
  version @_ver
  compatibility 'all'
  source_url "https://poppler.freedesktop.org/poppler-#{@_ver}.tar.xz"
  source_sha256 'fd51ead4aac1d2f4684fa6e7b0ec06f0233ed21667e720a4e817e4455dd63d27'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.03.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.03.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.03.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.03.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a4cb106683c7b8d289553fe9073201329619519f30ecc623dc6d08dbfd4eccb7',
     armv7l: 'a4cb106683c7b8d289553fe9073201329619519f30ecc623dc6d08dbfd4eccb7',
       i686: '54adf5a92963371ef36fbfa9078554b8539877bb036569d4f1b5d8627f7d2ddb',
     x86_64: '4133f3f21f6ed0a9d6530dbe4d4d5467984958479e69f56061c25e2ff42fb4dc'
  })

  depends_on 'boost'
  depends_on 'cairo'
  depends_on 'freeglut'
  depends_on 'harfbuzz'
  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'openjpeg'
  depends_on 'poppler_data'
  depends_on 'qttools'

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
