require 'package'

class Gdal < Package
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'http://www.gdal.org/'
  version '2.2.1'
  source_url 'http://download.osgeo.org/gdal/2.2.1/gdal-2.2.1.tar.xz'
  source_sha256 '927098d54083ac919a497f787b835b099e9a194f2e5444dbff901f7426b86066'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4c384905671538d0eb26a9e29a8dc7d3b2cf5e3e429282c637a138e11c5d75d2',
     armv7l: '4c384905671538d0eb26a9e29a8dc7d3b2cf5e3e429282c637a138e11c5d75d2',
       i686: '8f6a1b7c965c3e58eda805e91c8ecc3e7f145aff766d34f15c2186ff4c3c22fe',
     x86_64: 'b23583b8becbb229b1f6b958c4ab04374ddfdae0d22c506739bea3af25fdf9a0',
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
