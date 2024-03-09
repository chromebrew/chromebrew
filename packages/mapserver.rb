require 'package'

class Mapserver < Package
  description 'MapServer is an Open Source platform for publishing spatial data and interactive mapping applications to the web.'
  homepage 'http://mapserver.org/'
  version '8.0.0'
  license 'Boost-1.0, BSD-2, ISC, MIT and tcltk'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'http://download.osgeo.org/mapserver/mapserver-8.0.0.tar.gz'
  source_sha256 'bb7ee625eb6fdce9bd9851f83664442845d70d041e449449e88ac855e97d773c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1369f2cc35af3f53ae7c3514b592b9b7dd3e6552b13f0951dbc1fb5d5d70d7c8',
     armv7l: '1369f2cc35af3f53ae7c3514b592b9b7dd3e6552b13f0951dbc1fb5d5d70d7c8',
     x86_64: '803eb10f06933eff71eea4138ad9bd81a3abb8c81d707e9df268abe12f8842f3'
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
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libpng' # R
  depends_on 'libxml2' # R
  depends_on 'protobuf_c' # R
  depends_on 'zlibpkg' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
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
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
