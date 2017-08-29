require 'package'

class Geos < Package
  description 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  homepage 'https://trac.osgeo.org/geos/'
  version '3.6.2'
  source_url 'http://download.osgeo.org/geos/geos-3.6.2.tar.bz2'
  source_sha256 '045a13df84d605a866602f6020fc6cbf8bf4c42fb50de237a08926e1d7d7652a'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure CFLAGS=" -fPIC"'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
