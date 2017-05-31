require 'package'

class Mapserver < Package
  description 'MapServer is an Open Source platform for publishing spatial data and interactive mapping applications to the web.'
  homepage 'http://mapserver.org/'
  version '7.0.4'
  source_url 'http://download.osgeo.org/mapserver/mapserver-7.0.4.tar.gz'
  source_sha1 '8fb13c27da5902e6d9ad50f3eba550bd90750607'
  
  depends_on 'cmake'
  depends_on 'freetype'
  depends_on 'cairo'
  depends_on 'curl'

  def self.build
    system "mkdir build"
    Dir.chdir "build" do
      system "cmake -DWITH_THREAD_SAFETY=1 -DWITH_HARFBUZZ=0 -DWITH_FRIBIDI=0 -DWITH_FCGI=0 -DWITH_POSTGIS=0 -DWITH_GIF=0 -DWITH_CLIENT_WFS=1 -DWITH_CLIENT_WMS=1 -DWITH_CURL=1 -DCMAKE_C_FLAGS=\" -fPIC\" -DCMAKE_INSTALL_PREFIX=/usr/local .. > ../configure.out.txt"
      system "make"
    end
  end

  def self.install
    Dir.chdir "build" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
