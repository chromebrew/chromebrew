require 'package'

class Gnome_sudoku < Package
  description 'Sudoku puzzle game for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Sudoku'
  version '3.38.0'
  revision 1
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gnome-sudoku/#{version.rpartition('.')[0]}/gnome-sudoku-#{version}.tar.xz"
  source_sha256 '38731d0cc6d56a21dbdc89409cc5bb3d08e1c02cd9009f4d57f5b34887e9fd32'

  depends_on 'clutter_gtk'
  depends_on 'gsound'
  depends_on 'librsvg'
  depends_on 'qqwing'
  depends_on 'sommelier'

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
