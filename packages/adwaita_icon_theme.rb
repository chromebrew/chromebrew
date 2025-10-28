require 'buildsystems/meson'

class Adwaita_icon_theme < Meson
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://wiki.gnome.org/Design'
  version '49.0'
  license 'LGPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52883301b4615054f31d5fff23d0e518f05f506dbc29790b0f3f74078959d6bf',
     armv7l: '52883301b4615054f31d5fff23d0e518f05f506dbc29790b0f3f74078959d6bf',
     x86_64: '157920f95618f15e8ebcf7bc0416102dfed9365bced5b8dffb0bafd30eb9fc9f'
  })

  depends_on 'adwaita_fonts' # L
  depends_on 'gdk_pixbuf' => :build
  depends_on 'gtk3' => :build
  depends_on 'librsvg' => :build
  depends_on 'vala' => :build
  depends_on 'xdg_base'

  gnome
end
