require 'package'

class Mapserver < Package
  description 'MapServer is an Open Source platform for publishing spatial data and interactive mapping applications to the web.'
  homepage 'http://mapserver.org/'
  version '7.0.6'
  source_url 'http://download.osgeo.org/mapserver/mapserver-7.0.6.tar.gz'
  source_sha256 'dcbebd62976deef1490b084d8f6a0b2f2a1a25407efb6e058390025375539507'

  depends_on 'cmake'
  depends_on 'cairo'
  depends_on 'curl'
  depends_on 'fribidi'
  depends_on 'gdal'
  depends_on 'geos'
  depends_on 'harfbuzz'
  depends_on 'libjpeg'
  depends_on 'proj4'

  def self.build
    system "mkdir build"
    Dir.chdir "build" do
      system "cmake \
              -DWITH_CLIENT_WFS=1 \
              -DWITH_CLIENT_WMS=1 \
              -DWITH_CURL=1 \
              -DWITH_FCGI=0 \
              -DWITH_FRIBIDI=1 \
              -DWITH_GDAL=1 \
              -DWITH_GIF=0 \
              -DWITH_HARFBUZZ=1 \
              -DWITH_OGR=1 \
              -DWITH_POSTGIS=0 \
              -DWITH_PROJ=1 \
              -DWITH_THREAD_SAFETY=1 \
              -DWITH_WCS=1 \
              -DCMAKE_C_FLAGS=\" -fPIC\" \
              -DCMAKE_INSTALL_PREFIX=/usr/local .. > ../configure.out.txt"
      system "make"
    end
  end

  def self.install
    Dir.chdir "build" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
