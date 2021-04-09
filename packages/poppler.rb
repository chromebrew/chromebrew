require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  @_ver = '21.03.0'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://poppler.freedesktop.org/poppler-#{@_ver}.tar.xz"
  source_sha256 'fd51ead4aac1d2f4684fa6e7b0ec06f0233ed21667e720a4e817e4455dd63d27'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.03.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.03.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.03.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-21.03.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '97b54286c9ff1d7c041ea465e586f797a3bf3e426ce16fc39b753feef2380161',
     armv7l: '97b54286c9ff1d7c041ea465e586f797a3bf3e426ce16fc39b753feef2380161',
       i686: 'b2bee26bfa243a2eb3290b9784b619215b0d46e0edf802a0088a96944ef6caa1',
     x86_64: 'b1be0800a8af1881d28ad9c4f7f6ccabf351155d39787717da5a834f3aec59e8'
  })

  depends_on 'boost'
  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freeglut'
  depends_on 'freetype'
  depends_on 'glib'
  depends_on 'harfbuzz'
  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'nspr'
  depends_on 'nss'
  depends_on 'openjpeg'
  depends_on 'poppler_data'
  depends_on 'qtbase'
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
