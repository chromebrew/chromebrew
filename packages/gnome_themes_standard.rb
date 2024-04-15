require 'buildsystems/autotools'

class Gnome_themes_standard < Autotools
  description 'Standard Themes for GNOME Applications.'
  homepage 'https://git.gnome.org/browse/gnome-themes-standard/'
  version '3.28'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-themes-extra.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5cdf9a9406c8dd195a672c06633b88f7f1fdecaf01a151062cc76587b2be051',
     armv7l: 'd5cdf9a9406c8dd195a672c06633b88f7f1fdecaf01a151062cc76587b2be051',
     x86_64: '2b7a777ab2ef2ac11b2a13d281033f4b4dccc4bef364b25a36eca28c29e0ad5d'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_common' => :build
  depends_on 'gtk3' => :build
  depends_on 'harfbuzz' # R
  depends_on 'librsvg' => :build
  depends_on 'pango' # R
  depends_on 'gtk2' # R

  gnome
end
