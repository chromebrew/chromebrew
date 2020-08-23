require 'package'

class Garcon < Package
  description 'Glib/GIO freedesktop.org compliant menu implementation'
  homepage 'https://xfce.org/'
  version '0.7.0'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/garcon/0.7/garcon-0.7.0.tar.bz2'
  source_sha256 '82c3b61b508011642b09e6fb01b1d3f22c4e4de0fc54a9244327d0ddb66b2423'

  depends_on 'libxfce4ui'

  def self.build
      system "./configure #{CREW_OPTIONS} --disable-static"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end