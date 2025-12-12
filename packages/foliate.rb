require 'buildsystems/meson'

class Foliate < Meson
  description 'A simple and modern GTK eBook reader'
  homepage 'https://johnfactotum.github.io/foliate/'
  version '3.3.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/johnfactotum/foliate.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d344af5950666990013d5bd305085c1006f5afa35105c040cff190e1889a39c',
     armv7l: '8d344af5950666990013d5bd305085c1006f5afa35105c040cff190e1889a39c',
     x86_64: '9da89c44726d8521e3d99dd6f4387273dde9f0b7d31ac643cd875568d13153b5'
  })

  depends_on 'desktop_file_utils'
  depends_on 'gdk_base'
  depends_on 'gettext' => :build
  depends_on 'gjs'
  depends_on 'gtk4'
  depends_on 'iso_codes'
  depends_on 'libadwaita'
  depends_on 'sommelier'
  depends_on 'webkitgtk_6'

  gnome
end
