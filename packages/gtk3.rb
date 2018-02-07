require 'package'

class Gtk3 < Package
  description 'Gtk3 is a cross-platform widget toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.26'
  source_url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/3.22/gtk+-3.22.26.tar.xz'
  source_sha256 '61eef0d320e541976e2dfe445729f12b5ade53050ee9de6184235cb60cd4b967'

  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gdk_pixbuf'
  depends_on 'cairo'
  depends_on 'pango'
  depends_on 'libepoxy'
  depends_on 'graphene'
  depends_on 'atk'
  depends_on 'libxkbcommon'
  depends_on 'meson'
  depends_on 'ninja'
  depends_on 'python3'
  depends_on 'libx11'
  depends_on 'at_spi2_atk'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
