require 'package'

class Gtk3 < Package
  description 'Gtk3 is a cross-platform widget toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.22.29-0'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtk+/3.22/gtk+-3.22.29.tar.xz'
  source_sha256 'a07d64b939fcc034a066b7723fdf9b24e92c9cfb6a8497593f3471fe56fbbbf8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.29-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.29-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.29-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.29-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bdf7541925c1708e2517346b2138cccd81fabd6a73e3d2eb5d2bc27817b9d90e',
     armv7l: 'bdf7541925c1708e2517346b2138cccd81fabd6a73e3d2eb5d2bc27817b9d90e',
       i686: '7cae5db165ff66b908163272e0aac0f361238e0eaed6f04c91ab3f0ebbee2b7b',
     x86_64: 'f55a4969e7f0ddbeed5586455864d3b83345c1f6b0ef4c2b6fcb000046d56e9d',
  })

  depends_on 'xorg_lib'
  depends_on 'gdk_pixbuf'
  depends_on 'libepoxy'
  depends_on 'graphene'
  depends_on 'libxkbcommon'
  depends_on 'at_spi2_atk'
  depends_on 'six' => :build

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--enable-broadway-backend",
           "--enable-x11-backend",
           "--enable-wayland-backend"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    # generate schemas
    system "mkdir -p #{CREW_DEST_PREFIX}/share/glib-2.0/schemas"
    system "glib-compile-schemas #{CREW_DEST_PREFIX}/share/glib-2.0/schemas"
  end
end
