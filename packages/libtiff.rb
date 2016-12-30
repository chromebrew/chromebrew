require 'package'

class Libtiff < Package
  version '4.0.7'
  source_url 'ftp://download.osgeo.org/libtiff/tiff-4.0.7.tar.gz'
  source_sha1 '2c1b64478e88f93522a42dd5271214a0e5eae648'

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
