require 'package'

class Geos < Package
  description 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  homepage 'https://trac.osgeo.org/geos/'
  version '3.4.2-1'
  source_url 'http://download.osgeo.org/geos/geos-3.4.2.tar.bz2'
  source_sha256 '15e8bfdf7e29087a957b56ac543ea9a80321481cef4d4f63a7b268953ad26c53'

  def self.build
    system "./configure CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
