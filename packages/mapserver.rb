require 'package'

class Mapserver < Package
  description 'MapServer is an Open Source platform for publishing spatial data and interactive mapping applications to the web.'
  homepage 'http://mapserver.org/'
  version '7.0.6'
  compatibility 'all'
  source_url 'http://download.osgeo.org/mapserver/mapserver-7.0.6.tar.gz'
  source_sha256 'dcbebd62976deef1490b084d8f6a0b2f2a1a25407efb6e058390025375539507'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mapserver-7.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mapserver-7.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mapserver-7.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mapserver-7.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3779fc38a83229c289aa32a8d6610af0a379d08296ff9639c153f6b5a44b1174',
     armv7l: '3779fc38a83229c289aa32a8d6610af0a379d08296ff9639c153f6b5a44b1174',
       i686: '2fd2e786969a35a7eba1e23d1e499e9528375c499a72b29d3e7b9db49496574a',
     x86_64: '30aee13618652273e99735b3bb6ea83e3623598ccdcb353a954143711995bc04',
  })

  depends_on 'cmake'
  depends_on 'cairo'
  depends_on 'curl'
  depends_on 'fribidi'
  depends_on 'gdal'
  depends_on 'geos'
  depends_on 'glib'
  depends_on 'harfbuzz'
  depends_on 'libjpeg'
  depends_on 'proj4'

  def self.build
    system "mkdir build"
    Dir.chdir "build" do
      system "cmake \
              -DFRIBIDI_INCLUDE_DIR=`pkg-config fribidi --cflags-only-I|sed -e 's/^-I//' -e 's/ -I/;/g'` \
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
              -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} .. > ../configure.out.txt"
      system "make"
    end
  end

  def self.install
    Dir.chdir "build" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
