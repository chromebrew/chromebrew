require 'buildsystems/meson'

class Adwaita_icon_theme < Meson
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://wiki.gnome.org/Design'
  version '51.0'
  license 'LGPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7da8a19c9e19d229f26ee853d9945a07b92fd0b52cbc33086c1d20ea1186b162',
     armv7l: '7da8a19c9e19d229f26ee853d9945a07b92fd0b52cbc33086c1d20ea1186b162',
     x86_64: '9d0463a930b1835f877c01b2bfd29063661c114f8695e6cd0a528ff495204ae0'
  })

  depends_on 'adwaita_fonts' => :logical
  depends_on 'gdk_pixbuf' => :build
  depends_on 'gtk3' => :build
  depends_on 'librsvg' => :build
  depends_on 'vala' => :build
  depends_on 'xdg_base'

  gnome
end
