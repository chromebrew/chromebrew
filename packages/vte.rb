require 'buildsystems/meson'

class Vte < Meson
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  version "0.80.3-#{CREW_ICU_VER}"
  license 'LGPL-2+ and GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1e4976f63cc6c1986e9bc1e243ac6a543b5c340e54b1da2b4451481cdeb07f55',
     armv7l: '1e4976f63cc6c1986e9bc1e243ac6a543b5c340e54b1da2b4451481cdeb07f55',
     x86_64: 'e656fe422f27715cd70be71b5df9c5e851b9e5eb01d07262bce2d65bc2ba6725'
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
  depends_on 'lz4' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'zlib' => :build

  gnome
  no_lto

  meson_options '-D_systemd=false \
      -Dfribidi=true \
      -Dgtk3=true \
      -Dgtk4=true \
      -Dgir=false \
      -Dvapi=false'

  def self.patch
    system "sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,' src/minifont-coverage.py"
  end
end
