require 'package'

class Geos < Package
  description 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  homepage 'https://trac.osgeo.org/geos/'
  version '3.4.2-1'
  source_url 'http://download.osgeo.org/geos/geos-3.4.2.tar.bz2'
  source_sha1 'b8aceab04dd09f4113864f2d12015231bb318e9a'

  def self.build
    system "./configure CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
