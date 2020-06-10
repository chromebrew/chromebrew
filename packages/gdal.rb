require 'package'

class Gdal < Package
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'http://www.gdal.org/'
  version '2.4.3'
  compatibility 'all'
  source_url 'https://download.osgeo.org/gdal/2.4.3/gdal-2.4.3.tar.xz'
  source_sha256 'd52dc3e0cff3af3e898d887c4151442989f416e839948e73f0994f0224bbff60'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '78c04f34a1ca8422898d284f7f9696ba6d058c2a1dad9174baeca18a0ca117d1',
     armv7l: '78c04f34a1ca8422898d284f7f9696ba6d058c2a1dad9174baeca18a0ca117d1',
       i686: 'de81c48629f0a44765448cfb43180a394e6714c2c393f1f0262a46f250ad12d1',
     x86_64: '4b6a3d00c6149d1e71fa829f3d6c0b7113c3ad0dca9452da5304447d1ce1598f',
  })

  depends_on 'python27'
  depends_on 'openjpeg'
  depends_on 'curl'
  depends_on 'geos'
  depends_on 'proj4'
  depends_on 'libxml2'

  def self.build
    system 'filefix'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-png=internal',
           '--with-libtiff=internal',
           '--with-geotiff=internal',
           '--with-jpeg=internal',
           '--with-gif=internal',
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
