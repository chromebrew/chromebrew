require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.0.9'
  source_url 'ftp://download.osgeo.org/libtiff/tiff-4.0.9.tar.gz'
  source_sha256 '6e7bdeec2c310734e734d19aae3a71ebe37a4d842e0e23dbb1b8921c0026cfcd'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure \
            CFLAGS=\" -fPIC\" \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  depends_on 'compressdoc' => :build
  depends_on 'libjpeg'
  depends_on 'zlibpkg'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man3"
  end
end
