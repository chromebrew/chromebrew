require 'package'

class Gdal < Package
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'http://www.gdal.org/'
  version '1.11.5'
  source_url 'http://download.osgeo.org/gdal/1.11.5/gdal-1.11.5.tar.xz'
  source_sha256 'd4fdc3e987b9926545f0a514b4328cd733f2208442f8d03bde630fe1f7eff042'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-1.11.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-1.11.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-1.11.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-1.11.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8ef717c1286b5f114a22326f88cdad52e2e2605600fb5f47334b85d74240f091',
     armv7l: '8ef717c1286b5f114a22326f88cdad52e2e2605600fb5f47334b85d74240f091',
       i686: 'e01778f779613e44fa74ba4cb0af30ff19690987e76c484784462dd667891bcf',
     x86_64: '53f920cb22033654c94ba6fc8917cd39d42800b1cf574dbf8a7e453b3d2c1fa8',
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
