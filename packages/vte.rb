require 'buildsystems/meson'

class Vte < Meson
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  version "0.84.1-#{CREW_ICU_VER}"
  license 'LGPL-2+ and GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eecc6358aa495731dc45e9cbf197b045ccbb68f5adba0d6cab0612fdd0df2a90',
     armv7l: 'eecc6358aa495731dc45e9cbf197b045ccbb68f5adba0d6cab0612fdd0df2a90',
     x86_64: '9c837e978b605aaaf22c7dda068ac27159df14bd27970aeb3a5942bf526aa12b'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'fribidi' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
