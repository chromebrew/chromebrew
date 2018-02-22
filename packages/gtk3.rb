require 'package'

class Gtk3 < Package
  description 'Gtk3 is a cross-platform widget toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.22.26'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtk+/3.22/gtk+-3.22.26.tar.xz'
  source_sha256 '61eef0d320e541976e2dfe445729f12b5ade53050ee9de6184235cb60cd4b967'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.26-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.26-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.26-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.26-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '797be95ad482f46e7d032a39f08fe69a41526f973a8c3f8f5b5a736e39f4a54b',
     armv7l: '797be95ad482f46e7d032a39f08fe69a41526f973a8c3f8f5b5a736e39f4a54b',
       i686: '76f237689e829c88368c4f6ec65832b8431008ac26d726f44ed7cc40fc67277e',
     x86_64: 'bbf2cb9a8a2660fb4474ca1be8d18424f7c6099397b025c4f4917b7ea7789f30',
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
