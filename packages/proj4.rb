require 'package'

class Proj4 < Package
  description 'proj.4 is a standard Unix filter function which converts geographic longitude and latitude coordinates into cartesian coordinates (and vice versa), and it is a C API for software developers to include coordinate transformation in their own software.'
  homepage 'http://proj4.org/'
  version '4.9.3'
  source_url 'http://download.osgeo.org/proj/proj-4.9.3.tar.gz'
  source_sha256 '6984542fea333488de5c82eea58d699e4aff4b359200a9971537cd7e047185f7'

  def self.build
    system './configure CFLAGS=" -fPIC"'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
