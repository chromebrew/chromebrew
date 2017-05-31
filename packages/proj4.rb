require 'package'

class Proj4 < Package
  description 'proj.4 is a standard Unix filter function which converts geographic longitude and latitude coordinates into cartesian coordinates (and vice versa), and it is a C API for software developers to include coordinate transformation in their own software.'
  homepage 'http://proj4.org/'
  version '4.9.1-1'
  source_url 'http://download.osgeo.org/proj/proj-4.9.1.tar.gz'
  source_sha1 '0bc63a41f1bdcff600d076c056f796007abf3f2f'

  def self.build
    system "./configure CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
