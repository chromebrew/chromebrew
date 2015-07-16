require 'package'

class Proj4 < Package
  version '4.9.1'
  source_url 'http://download.osgeo.org/proj/proj-4.9.1.tar.gz'
  source_sha1 '0bc63a41f1bdcff600d076c056f796007abf3f2f'

  def self.build
    system "./configure --libdir=/usr/local/lib64/ CC=\"gcc -m64\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
