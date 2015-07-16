require 'package'

class Gdal < Package
  version '1.11.2'
  source_url 'http://download.osgeo.org/gdal/1.11.2/gdal-1.11.2.tar.gz'
  source_sha1 '6f3ccbe5643805784812072a33c25be0bbff00db'

  depends_on 'python27'
  depends_on 'curl'
  depends_on 'geos'
  depends_on 'proj4'
  depends_on 'libxml2'

  def self.build
    system "./configure --libdir=/usr/local/lib64/ CC=\"gcc -m64\" CFLAGS=\" -fPIC\" --with-png=internal --with-libtiff=internal --with-geotiff=internal --with-jpeg=internal --with-gif=internal --with-curl=/usr/local/bin/curl-config --with-geos=/usr/local/bin/geos-config --with-static-proj4=/usr/local/share/proj --with-python --with-mrsid=/home/chronos/user/Downloads/mrsid/MrSID_DSDK-9.1.0.4045-linux.x86-64.gcc44/Raster_DSDK"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
