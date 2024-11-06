require 'buildsystems/meson'

class Libgnome_games_support2 < Meson
  description 'libgnome-games-support is a small library intended for internal use by GNOME Games.'
  homepage 'https://gitlab.gnome.org/GNOME/libgnome-games-support'
  version '2.0.0' # 2.0.0 is out, but gnome_mines and gnome_klotski don't work with it yet.
  license 'LGPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgnome-games-support.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3b0e9d28efba3a1f06d457bb3dc563f55baac3534d7b64d574859113382e6ff',
     armv7l: 'a3b0e9d28efba3a1f06d457bb3dc563f55baac3534d7b64d574859113382e6ff',
     x86_64: '318f2dcd5a705429c0315432f37761039daa3615d33be99589365f861ffa97c5'
  })

  depends_on 'clutter' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk4' # R
  depends_on 'libgee' # R
  depends_on 'vala' => :build

  gnome
end
