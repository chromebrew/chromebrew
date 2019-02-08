require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.24.3'
  source_url 'https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.3.tar.xz'
  source_sha256 '5708fa534d964b1fb9a69d15758729d51b9a438471d4612dc153f595904803bd'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gdk_pixbuf'
  depends_on 'json_glib'
  depends_on 'libepoxy'
  depends_on 'graphene'
  depends_on 'libxkbcommon'
  depends_on 'at_spi2_atk'
  depends_on 'gobject_introspection'
  depends_on 'cups'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'shared_mime_info'
  depends_on 'six' => :build

  def self.build
    system "./configure",
           "--enable-cups",
           "--disable-debug",
           "--enable-x11-backend",
           "--enable-introspection",
           "--prefix=#{CREW_PREFIX}",
           "--enable-wayland-backend",
           "--enable-broadway-backend",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    # generate schemas
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    system "update-mime-database #{CREW_PREFIX}/share/mime"
  end
end
