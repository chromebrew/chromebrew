require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  @_ver = '0.70.0'
  version "#{@_ver}-1"
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.70.0-1_armv7l/vte-0.70.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.70.0-1_armv7l/vte-0.70.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.70.0-1_i686/vte-0.70.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.70.0-1_x86_64/vte-0.70.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6ab56bce567f65eeab081b9fa45673a68b51c37fd1adfbf292cac5c4d14e840c',
     armv7l: '6ab56bce567f65eeab081b9fa45673a68b51c37fd1adfbf292cac5c4d14e840c',
       i686: '6af08fe4156f0af3b3fa9fd1c3839bffd94ebabd8afdc503868eee357b31637c',
     x86_64: 'a4be13fcccff562384060a74288c9e7109cd63d120a0a9383604e53b1480e986'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'fribidi'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'atk' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'zlibpkg' # R
  depends_on 'at_spi2_core' # R

  gnome

  def self.build
    system <<~CONFIGURE
      meson \
      #{CREW_MESON_FNO_LTO_OPTIONS.gsub('-fno-lto', '-fno-lto -fno-stack-protector')} \
      -D_systemd=false \
      -Dfribidi=true \
      -Dgtk3=true \
      -Dgtk4=true \
      -Dgir=false \
      -Dvapi=false \
      builddir
    CONFIGURE

    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
