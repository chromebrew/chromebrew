require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.0.8'
  source_url 'ftp://download.osgeo.org/libtiff/tiff-4.0.8.tar.gz'
  source_sha256 '59d7a5a8ccd92059913f246877db95a2918e6c04fb9d43fd74e5c3390dac2910'

  def self.build
    system "./configure CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
