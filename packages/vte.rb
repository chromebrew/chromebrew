require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  @_ver = '0.71.92'
  version @_ver
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.71.92_armv7l/vte-0.71.92-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.71.92_armv7l/vte-0.71.92-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.71.92_i686/vte-0.71.92-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.71.92_x86_64/vte-0.71.92-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1b34b6cdf4755b9b2701de67bba27207c057e4f3cedab5c1787240f40bf68048',
     armv7l: '1b34b6cdf4755b9b2701de67bba27207c057e4f3cedab5c1787240f40bf68048',
       i686: '8f23401336fe44e7d0a921c544cd79efb36ce13d362df6eb420630f6832b38b9',
     x86_64: '8e05cc8656261e324f8189fb55cb0289696209c7ad49d1b0971bfeff0eab42b8'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'fribidi'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'at_spi2_core' # R
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
