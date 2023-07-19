require 'package'

class Libgnome_games_support < Package
  description 'libgnome-games-support is a small library intended for internal use by GNOME Games.'
  homepage 'https://gitlab.gnome.org/GNOME/libgnome-games-support'
  version '1.8.1'
  license 'LGPL-3+'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/libgnome-games-support/#{version.rpartition('.')[0]}/libgnome-games-support-#{version}.tar.xz"
  source_sha256 'c37b7acd3ba7eb12207f5d7bb020535fa5783b0bd897e51b2bd629ce119a413f'

  depends_on 'gtk3'
  depends_on 'libgee'
  depends_on 'clutter'

  def self.build
    system "meson setup #{CREW_MESON_FNO_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
