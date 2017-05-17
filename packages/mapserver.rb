require 'package'

class Mapserver < Package
  version '5.6.9-1'
  source_url 'http://download.osgeo.org/mapserver/mapserver-5.6.9.tar.gz'
  source_sha1 '3f05bf6c9a32b34408e36ddd32f61d68d65cf01c'

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --with-gdal=/usr/local/bin/gdal-config --with-ogr --with-png --with-jpeg --without-pdf --with-agg --with-proj --with-threads --with-geos=/usr/local/bin/geos-config --with-tiff --with-wfs --with-wmsclient --with-wfsclient --with-curl-config=/usr/local/bin/curl-config --with-xml2-config=/usr/local/bin/xml2-config"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
