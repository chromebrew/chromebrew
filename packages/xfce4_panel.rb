require 'package'

class Xfce4_panel < Package
  description 'Next generation panel for the XFCE desktop environment'
  homepage 'https://xfce.org/'
  version '4.14.4'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/xfce4-panel/4.14/xfce4-panel-4.14.4.tar.bz2'
  source_sha256 '8e5ea79412ba84cfada897ff309cbe2cd4aca16b9bd4f93df060229528576fd5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_panel-4.14.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_panel-4.14.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_panel-4.14.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_panel-4.14.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '283544affaec2a778d61b6f93a3b1c0b5dc3c59569cef42522d38e888afeb725',
     armv7l: '283544affaec2a778d61b6f93a3b1c0b5dc3c59569cef42522d38e888afeb725',
       i686: 'fbc48b16e7c35e54096170b94cf1db6a662886bbd43937974f0df20812adb8e3',
     x86_64: 'e75c8e2317baef70266e4b4c8643d4d704c4fa082104290bbae97178392f870f',
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
  
  def self.postinstall
    puts
    puts "You need a window manager like 'openbox' to use with this package.".lightblue
end
