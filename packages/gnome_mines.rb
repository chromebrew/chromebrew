require 'buildsystems/meson'

class Gnome_mines < Meson
  description 'GNOME Mines (formerly known as Gnomine) is minesweeper clone for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Mines'
  @_ver = '3.36.1'
  version "#{@_ver}-1"
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://download.gnome.org/sources/gnome-mines/#{@_ver.rpartition('.')[0]}/gnome-mines-#{@_ver}.tar.xz"
  source_sha256 '7188130d6faee1b87ca92295da196ad27139801ca793ea6b0c665a9232404654'

  depends_on 'clutter_gtk'
  depends_on 'gsound'
  depends_on 'librsvg'
  depends_on 'libgnome_games_support'
  depends_on 'wayland'

  gnome
  no_lto
end
