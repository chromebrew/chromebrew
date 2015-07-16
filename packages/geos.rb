require 'package'

class Geos < Package
  version '3.4.2'
  source_url 'http://download.osgeo.org/geos/geos-3.4.2.tar.bz2'
  source_sha1 'b8aceab04dd09f4113864f2d12015231bb318e9a'

  def self.build
    system "./configure --libdir=/usr/local/lib64/ CC=\"gcc -m64\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
