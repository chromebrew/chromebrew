require 'package'

class Xfce4_panel < Package
  description 'Next generation panel for the XFCE desktop environment'
  homepage 'https://xfce.org/'
  version '4.16.0'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/xfce4-panel/4.16/xfce4-panel-#{version}.tar.bz2"
  source_sha256 '5e979aeeb37d306d72858b1bc67448222ea7a68de01409055b846cd31f3cc53d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_panel-4.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_panel-4.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_panel-4.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_panel-4.16.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '338ec0279e7da70d8748e5a434b82a52230f2f0359903e1a93488e144c8b9c1b',
     armv7l: '338ec0279e7da70d8748e5a434b82a52230f2f0359903e1a93488e144c8b9c1b',
       i686: 'ddcb71b0ab71cb33e90c1d0eee09aafbe3aa70d5b76c6e35a6174ecfed8489c5',
     x86_64: 'a756559d9682ea4857c576af6b305c8ee29e1c8d59b9776cdf9b85de07bc7130',
  })

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
