require 'package'

class Xfce4_panel < Package
  description 'Next generation panel for the XFCE desktop environment'
  homepage 'https://xfce.org/'
  version '4.16.0'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/xfce4-panel/4.16/xfce4-panel-#{version}.tar.bz2"
  source_sha256 '5e979aeeb37d306d72858b1bc67448222ea7a68de01409055b846cd31f3cc53d'

  depends_on 'libwnck'
  depends_on 'libxfce4ui'
  depends_on 'xfconf'
  depends_on 'garcon'
  depends_on 'exo'
  depends_on 'gtk3'

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-static --enable-gio-unix --enable-gtk2"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
