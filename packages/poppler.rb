require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  version '20.10.0'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://poppler.freedesktop.org/poppler-20.10.0.tar.xz'
  source_sha256 '434ecbbb539c1a75955030a1c9b24c7b58200b7f68d2e4269e29acf2f8f13336'

  binary_url ({
  })
  binary_sha256 ({
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
