require 'package'

class Gnome_mines < Package
  description 'GNOME Mines (formerly known as Gnomine) is minesweeper clone for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Mines'
  version '3.36.1'
  revision 1
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gnome-mines/#{version.rpartition('.')[0]}/gnome-mines-#{version}.tar.xz"
  source_sha256 '7188130d6faee1b87ca92295da196ad27139801ca793ea6b0c665a9232404654'

  depends_on 'clutter_gtk'
  depends_on 'gsound'
  depends_on 'librsvg'
  depends_on 'libgnome_games_support'
  depends_on 'wayland'

  def self.build
    system "meson setup #{CREW_MESON_FNO_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    system 'gdk-pixbuf-query-loaders --update-cache'
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
