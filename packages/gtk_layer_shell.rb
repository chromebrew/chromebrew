# Adapted from Arch Linux gtk-layer-shell PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/gtk-layer-shell/trunk/PKGBUILD

require 'buildsystems/meson'

class Gtk_layer_shell < Meson
  description 'Library to create Wayland desktop components using the Layer Shell protocol'
  homepage 'https://github.com/wmww/gtk-layer-shell'
  version '0.8.2'
  license 'LGPL3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/wmww/gtk-layer-shell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '689e9f3992779c13ec280cee60394577fd419fbaa79f3962b5551e8a096736b7',
     armv7l: '689e9f3992779c13ec280cee60394577fd419fbaa79f3962b5551e8a096736b7',
     x86_64: 'fca549d22f350feb268baf2ba75f280fa3152b52268377233f8b6b5174deaa85'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'wayland' # R
end
