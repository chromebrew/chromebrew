require 'package'

class Gtk3 < Package
  description 'Gtk3 is a cross-platform widget toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.22.26-0'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtk+/3.22/gtk+-3.22.26.tar.xz'
  source_sha256 '61eef0d320e541976e2dfe445729f12b5ade53050ee9de6184235cb60cd4b967'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.26-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.26-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.26-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.26-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd28da624022f0b307f9ed465c8080822384fd0f487b0737e93e40d7fa6c66ca8',
     armv7l: 'd28da624022f0b307f9ed465c8080822384fd0f487b0737e93e40d7fa6c66ca8',
       i686: '19c2cd6f3f3f5dac6bf26b378fed28e090aa96277e386f9dc3ada77fdd8cbc93',
     x86_64: 'e07a18dfb302dbfbf2e5c081873f48ac8d32757238fc4f9ef7060eff307ff90a',
  })

  depends_on 'gdk_pixbuf'
  depends_on 'libepoxy'
  depends_on 'graphene'
  depends_on 'libxkbcommon'
  depends_on 'at_spi2_atk'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"  # for installation process
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
  end
end
