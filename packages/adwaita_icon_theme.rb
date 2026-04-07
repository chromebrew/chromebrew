require 'buildsystems/meson'

class Adwaita_icon_theme < Meson
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://wiki.gnome.org/Design'
  version '50.0'
  license 'LGPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5eec5ea4caa7e47b213de5e2131009a1b1ae2795778751cdd1a7d648a1dfe3aa',
     armv7l: '5eec5ea4caa7e47b213de5e2131009a1b1ae2795778751cdd1a7d648a1dfe3aa',
     x86_64: 'ac5e811a399ac6975081848e51c08aa231ea4058c7d612baf9aad8f51287fdb7'
  })

  depends_on 'adwaita_fonts' => :logical
  depends_on 'gdk_pixbuf' => :build
  depends_on 'gtk3' => :build
  depends_on 'librsvg' => :build
  depends_on 'vala' => :build
  depends_on 'xdg_base'

  gnome
end
