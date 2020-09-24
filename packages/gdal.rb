require 'package'

class Gdal < Package
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'http://www.gdal.org/'
  version '3.1.3'
  compatibility 'all'
  source_url 'https://download.osgeo.org/gdal/3.1.3/gdal-3.1.3.tar.xz'
  source_sha256 '161cf55371a143826f1d76ce566db1f0a666496eeb4371aed78b1642f219d51d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-3.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-3.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-3.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-3.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4e650503583cdb958c514a681ef5ed4791dee197eadcdb9bf58ca574e6a7f034',
     armv7l: '4e650503583cdb958c514a681ef5ed4791dee197eadcdb9bf58ca574e6a7f034',
       i686: '6e168a4d3daadb0661241a56edbbba8d6ab2d54460c3079c2554420601b6a920',
     x86_64: '984599cb21608ba4ba15be1512981406b6c1e0c581c4e29ccb3d36452778b51e',
  })

  depends_on 'openjpeg'
  depends_on 'curl'
  depends_on 'geos'
  depends_on 'hdf5'
  depends_on 'proj4'
  depends_on 'qhull'
  depends_on 'libgeotiff'
  depends_on 'libxml2'
  depends_on 'xercesc'

  def self.build
    system 'filefix'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-curl=#{CREW_PREFIX}/bin/curl-config",
           "--with-geos=#{CREW_PREFIX}/bin/geos-config",
           '--with-python',
           '--with-proj'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
