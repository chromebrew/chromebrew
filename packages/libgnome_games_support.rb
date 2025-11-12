require 'buildsystems/meson'

class Libgnome_games_support < Meson
  description 'libgnome-games-support is a small library intended for internal use by GNOME Games.'
  homepage 'https://gitlab.gnome.org/GNOME/libgnome-games-support'
  version '2.0.2'
  license 'LGPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libgnome-games-support.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5154e770b824321f6981806bc604b72233e66b902a30c1e2c84171e11f4a08e',
     armv7l: 'c5154e770b824321f6981806bc604b72233e66b902a30c1e2c84171e11f4a08e',
     x86_64: 'd103aa843545add7198a0e9ee20949cbdf8982d4fc68c6e51864318f5557ddac'
  })

  depends_on 'clutter' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk4' # R
  depends_on 'libgee' # R
  depends_on 'vala' => :build

  gnome
end
