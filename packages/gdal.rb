require 'package'

class Gdal < Package
  description 'The Geospatial Data Abstraction Library is a translator for raster and vector geospatial data formats.'
  homepage 'http://www.gdal.org/'
  version '2.2.3'
  source_url 'http://download.osgeo.org/gdal/2.2.3/gdal-2.2.3.tar.xz'
  source_sha256 'a328d63d476b3653f5a25b5f7971e87a15cdf8860ab0729d4b1157ba988b8d0b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdal-2.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '87fc7a9a09710e991981b46d4507384e57580e118885ba1fe0f392fb39ae5b8c',
     armv7l: '87fc7a9a09710e991981b46d4507384e57580e118885ba1fe0f392fb39ae5b8c',
       i686: 'c3926343dd3c528b21ae50f3b30e5347c2bd0530227fd28b9503cde3539820f7',
     x86_64: 'f7a43568512f9426a7951b90006507e4d7080cb61d68fa152a3723c3e0c4e90e',
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
