require 'buildsystems/autotools'

class Keybinder < Autotools
  description 'Library for registering global key bindings, for gtk-based applications in X11. With gir bindings.'
  homepage 'https://github.com/kupferlauncher/keybinder'
  version '0.3.2'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/kupferlauncher/keybinder.git'
  git_hashtag "keybinder-3.0-v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74b44259a238632ff6e6488fae9a39b8d61a14e73f2812e04016aebbcaf48c1d',
     armv7l: '74b44259a238632ff6e6488fae9a39b8d61a14e73f2812e04016aebbcaf48c1d',
     x86_64: '7f3bf22ac0ac41370e6a0e6153256991a917e8ec05a6f85f433550860ba1b6e2'
  })

  depends_on 'gtk3' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'harfbuzz' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnome_common' # R
  depends_on 'gobject_introspection' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxrender' # R
  depends_on 'pango' # R

  run_tests
end
