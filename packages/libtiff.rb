require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.0.7-1'
  source_url 'ftp://download.osgeo.org/libtiff/tiff-4.0.7.tar.gz'
  source_sha256 '9f43a2cfb9589e5cecaa66e16bf87f814c945f22df7ba600d63aac4632c4f019'

  def self.build
    system "./configure CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
