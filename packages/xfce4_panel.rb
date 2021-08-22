require 'package'

class Xfce4_panel < Package
  description 'Next generation panel for the XFCE desktop environment'
  homepage 'https://xfce.org/'
  version '4.16.3'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/xfce4-panel/4.16/xfce4-panel-4.16.3.tar.bz2'
  source_sha256 '5934eaed8a76da52c29b734ccd79600255420333dd6ebd8fd9f066379af1e092'

  depends_on 'libwnck'
  depends_on 'libxfce4ui'
  depends_on 'xfconf'
  depends_on 'garcon'
  depends_on 'exo'
  depends_on 'gtk3'

  def self.patch
    system 'filefix'
  end
  
  def self.build
    system <<~BUILD
      [ -x autogen.sh ] && env NOCONFIGURE='1' ./autogen.sh
      env #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
        --disable-static \
        --enable-gio-unix

      make
    BUILD
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
  
  def self.postinstall
    system 'gtk-update-icon-cache',  '-f',  '-t', "#{CREW_PREFIX}/share/icons/hicolor"
  end
end
