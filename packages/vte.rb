require 'buildsystems/meson'

class Vte < Meson
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  version '0.75.92'
  license 'LGPL-2+ and GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2f391b5c913253e1f7f54647e2e410347ea12cc5cfb6b76e83c167ec8247f37',
     armv7l: 'f2f391b5c913253e1f7f54647e2e410347ea12cc5cfb6b76e83c167ec8247f37',
     x86_64: 'f7038e85f3b0ac3f50db80bca4ec6ea705b1ec9c666a74615bc0f94eb9467c56'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnutls' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'lz4' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'zlibpkg' => :build

  gnome
  no_lto

  meson_options '-D_systemd=false \
      -Dfribidi=true \
      -Dgtk3=true \
      -Dgtk4=true \
      -Dgir=false \
      -Dvapi=false'
end
