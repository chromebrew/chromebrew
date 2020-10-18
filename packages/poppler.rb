require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  version '20.10.0'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://poppler.freedesktop.org/poppler-20.10.0.tar.xz'
  source_sha256 '434ecbbb539c1a75955030a1c9b24c7b58200b7f68d2e4269e29acf2f8f13336'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-20.10.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-20.10.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-20.10.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '18bcbd800629d2d04750a6a3837fc9bff16dcea458e90a7e0e2d06d04a05917d',
     armv7l: '18bcbd800629d2d04750a6a3837fc9bff16dcea458e90a7e0e2d06d04a05917d',
     x86_64: '3d61a2ad5cff366fab3f502159cd5bd042d690ca18a8a289dd2423ed862a745c',
  })

  depends_on 'boost'
  depends_on 'cairo'
  depends_on 'curl'
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
      system 'cmake',
             "-DCMAKE_CXX_FLAGS='-std=c++11 -I#{CREW_PREFIX}/include/GL -I#{CREW_PREFIX}/include/openjpeg-2.3 -I#{CREW_PREFIX}/include'",
             "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DENABLE_UNSTABLE_API_ABI_HEADERS=on',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
