require 'package'

class Gdal < Package
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'http://www.gdal.org/'
  version '2.2.3'
  source_url 'http://download.osgeo.org/gdal/2.2.3/gdal-2.2.3.tar.xz'
  source_sha256 'a328d63d476b3653f5a25b5f7971e87a15cdf8860ab0729d4b1157ba988b8d0b'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27'
  depends_on 'curl'
  depends_on 'geos'
  depends_on 'proj4'
  depends_on 'libxml2'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-png=internal",
           "--with-libtiff=internal",
           "--with-geotiff=internal",
           "--with-jpeg=internal",
           "--with-gif=internal",
           "--with-curl=#{CREW_PREFIX}/bin/curl-config",
           "--with-geos=#{CREW_PREFIX}/bin/geos-config",
           "--with-static-proj4=#{CREW_PREFIX}/share/proj",
           "--with-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
