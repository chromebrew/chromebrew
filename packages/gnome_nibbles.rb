require 'package'

class Gnome_nibbles < Package
  description 'snake game, up to four players'
  homepage 'https://wiki.gnome.org/Apps/Nibbles'
  @_commit = '62964e9256fcac616109af874dbb2bd8342a9853'
  version "3.38.2+git+#{@_commit[0..8]}"
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-nibbles/-/archive/#{@_commit}/gnome-nibbles-#{@_commit}.tar.gz"
  source_sha256 'ebf93903d36ae939f9ae56f47bc0dea151a60dfe2c63962af84c517ef1d7aba4'

  depends_on 'clutter_gtk'
  depends_on 'gsound'
  depends_on 'librsvg'
  depends_on 'libgnome_games_support'
  depends_on 'wayland'

  def self.build
    system "meson setup #{CREW_MESON_FNO_LTO_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
