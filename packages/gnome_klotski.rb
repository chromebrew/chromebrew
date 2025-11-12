require 'buildsystems/meson'

class Gnome_klotski < Meson
  description 'A puzzle game for GNOME.'
  homepage 'https://wiki.gnome.org/Apps/Klotski'
  version '3.38.2-1'
  license 'GPL-3+ and FDL-1.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-klotski.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dfbf3c6ca1029686afa088d490faf198fd64f38d4d6dca558d76271aa7d31dce',
     armv7l: 'dfbf3c6ca1029686afa088d490faf198fd64f38d4d6dca558d76271aa7d31dce',
     x86_64: 'bd1c6705b5e4f09f13e94e8227e00ad8b098623b59d843079f7cee856a66e016'
  })

  depends_on 'cairo' # R
  depends_on 'clutter_gtk' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gsound'
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libgee' # R
  depends_on 'libgnome_games_support1' # R
  depends_on 'librsvg' # R

  gnome
end
