require 'buildsystems/meson'

class Libgnome_games_support < Meson
  description 'libgnome-games-support is a small library intended for internal use by GNOME Games.'
  homepage 'https://gitlab.gnome.org/GNOME/libgnome-games-support'
  version '1.8.2' # 2.0.0 is out, but gnome_mines and gnome_klotski don't work with it yet.
  license 'LGPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgnome-games-support.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f83e25e2fd800d309f96006eeb9c96f76ac11a6ab3370193427da0b7a8ba0b8',
     armv7l: '6f83e25e2fd800d309f96006eeb9c96f76ac11a6ab3370193427da0b7a8ba0b8',
     x86_64: 'a332d79955f7dd3e8804337410daea63b39cc41bd42b529acb61559cc4bed27b'
  })

  depends_on 'clutter'
  depends_on 'gtk3'
  depends_on 'libgee'
  depends_on 'vala' => :build

  gnome
end
