require 'buildsystems/meson'

class Gnome_klotski < Meson
  description 'A puzzle game for GNOME.'
  homepage 'https://wiki.gnome.org/Apps/Klotski'
  @_ver = '3.38.2'
  version "#{@_ver}-1"
  license 'GPL-3+ and FDL-1.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://download.gnome.org/sources/gnome-klotski/#{@_ver.rpartition('.')[0]}/gnome-klotski-#{@_ver}.tar.xz"
  source_sha256 '91637845649f3ca709d29f71ee775b946d1112087209f32264e8fad21a0ca0e2'
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
  depends_on 'libgnome_games_support' # R
  depends_on 'librsvg' # R

  gnome
end
