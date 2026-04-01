require 'buildsystems/meson'

class Vte < Meson
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  version "0.84.0-#{CREW_ICU_VER}"
  license 'LGPL-2+ and GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e555a800b38dad49da00bdda322e76f4afb846d465955d0a96d3a6af3e08020',
     armv7l: '8e555a800b38dad49da00bdda322e76f4afb846d465955d0a96d3a6af3e08020',
     x86_64: '4da6b5d68e1e09115a01a1b9f9eab3f75e7ef187c80164dbfe53df9dd9bb4204'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'fribidi' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gnutls' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' => :library
  depends_on 'gtk3' => :library
  depends_on 'gtk4' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'icu4c' => :library
  depends_on 'lz4' => :library
  depends_on 'pango' => :library
  depends_on 'pcre2' => :library
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
