require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  version '0.86.1'
  compatibility 'all'
  source_url 'https://poppler.freedesktop.org/poppler-0.86.1.tar.xz'
  source_sha256 'af630a277c8e194c31339c5446241834aed6ed3d4b4dc7080311e51c66257f6c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.86.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.86.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.86.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.86.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd7a3f4fbf1f47c73958e64b3ec1009865fe291f651de0dd6c5c25283a3bcc77d',
     armv7l: 'd7a3f4fbf1f47c73958e64b3ec1009865fe291f651de0dd6c5c25283a3bcc77d',
       i686: '1a79d3f532ba1d3d26da035676516cd7c1a184a3f703438ea615fa6d498416d4',
     x86_64: '214addecd68af303a0e158f5e0ccd4910aea8a0073340adc9098d1307a56bc36',
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
             "-DCMAKE_CXX_FLAGS='-I#{CREW_PREFIX}/include/GL -I#{CREW_PREFIX}/include/openjpeg-2.3 -I#{CREW_PREFIX}/include'",
             "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
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
