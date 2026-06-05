# Adapted from Arch Linux gtk-layer-shell PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/gtk-layer-shell/trunk/PKGBUILD

require 'buildsystems/meson'

class Gtk_layer_shell < Meson
  description 'Library to create Wayland desktop components using the Layer Shell protocol'
  homepage 'https://github.com/wmww/gtk-layer-shell'
  version '0.10.1'
  license 'LGPL3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/wmww/gtk-layer-shell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2de4a716525777afd7832a25c2b2dbfc08d173c40143a03c2c071e80efb046b',
     armv7l: 'f2de4a716525777afd7832a25c2b2dbfc08d173c40143a03c2c071e80efb046b',
     x86_64: 'bad153e8372f4cc180c57d023d9f0fa6de334f4593d486cd662279fac5a17cce'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :library
  depends_on 'gtk3' => :library
  depends_on 'vala' => :executable
  depends_on 'wayland' => :library
end
