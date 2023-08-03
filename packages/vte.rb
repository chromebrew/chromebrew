require 'buildsystems/meson'

class Vte < Meson
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  version '0.72.2'
  license 'LGPL-2+ and GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.72.2_armv7l/vte-0.72.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.72.2_armv7l/vte-0.72.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.72.2_x86_64/vte-0.72.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e90bfce1c8449ef74c9acf5a3eeb4f365ffa39c008fe398ff3c6b7042dfc3520',
     armv7l: 'e90bfce1c8449ef74c9acf5a3eeb4f365ffa39c008fe398ff3c6b7042dfc3520',
     x86_64: '1c86607d53f6a6f1738770c14b06df6e5cc95f43ce9e6d54a00a1f4ec97f3017'
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
  depends_on 'graphene' # R
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'zlibpkg' # R

  gnome
  no_lto

  meson_options '-D_systemd=false \
      -Dfribidi=true \
      -Dgtk3=true \
      -Dgtk4=true \
      -Dgir=false \
      -Dvapi=false'
end
