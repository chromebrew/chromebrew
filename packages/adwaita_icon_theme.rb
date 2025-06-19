require 'buildsystems/meson'

class Adwaita_icon_theme < Meson
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme'
  version '48.1'
  license 'LGPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06de63c23bbe5c4e66c749830329c43b98e41e6a52820541004a5464d06e0c19',
     armv7l: '06de63c23bbe5c4e66c749830329c43b98e41e6a52820541004a5464d06e0c19',
     x86_64: 'a1a77e319c1e926ca233d83a52a3643df3a45f2523429f25c3674573eddc8edf'
  })

  depends_on 'adwaita_fonts' # L
  depends_on 'gdk_pixbuf' => :build
  depends_on 'gtk3' => :build
  depends_on 'librsvg' => :build
  depends_on 'vala' => :build
  depends_on 'xdg_base'

  gnome
end
