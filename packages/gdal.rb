require 'package'

class Gdal < Package
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'http://www.gdal.org/'
  version '2.2.1'
  source_url 'http://download.osgeo.org/gdal/2.2.1/gdal-2.2.1.tar.xz'
  source_sha256 '927098d54083ac919a497f787b835b099e9a194f2e5444dbff901f7426b86066'

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
    system "./configure CFLAGS=\" -fPIC\" --with-png=internal --with-libtiff=internal --with-geotiff=internal --with-jpeg=internal --with-gif=internal --with-curl=/usr/local/bin/curl-config --with-geos=/usr/local/bin/geos-config --with-static-proj4=/usr/local/share/proj --with-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
