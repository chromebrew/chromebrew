require 'package'

class Xfce4_panel < Package
  description 'Next generation panel for the XFCE desktop environment'
  homepage 'https://xfce.org/'
  version '4.14.4'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/xfce4-panel/4.14/xfce4-panel-4.14.4.tar.bz2'
  source_sha256 '8e5ea79412ba84cfada897ff309cbe2cd4aca16b9bd4f93df060229528576fd5'

  depends_on 'libwnck'
  depends_on 'libxfce4ui'
  depends_on 'xfconf'
  depends_on 'garcon'
  depends_on 'exo'
  depends_on 'gtk3'

  def self.build
      system "./configure #{CREW_OPTIONS} --disable-static --enable-gio-unix --enable-gtk3"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end