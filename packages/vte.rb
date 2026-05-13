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
    aarch64: '9008f1a2ccf84cd59948dc0463529dcc013f97ca95aeae2052c8f296a8fc796b',
     armv7l: '9008f1a2ccf84cd59948dc0463529dcc013f97ca95aeae2052c8f296a8fc796b',
     x86_64: '7f4b390395674134b778a1f6a7907929b7283077dbb4c84c68ee1d6301c8698a'
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
