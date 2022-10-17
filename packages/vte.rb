require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  @_ver = '0.70.0'
  version @_ver
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.70.0_armv7l/vte-0.70.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.70.0_armv7l/vte-0.70.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.70.0_i686/vte-0.70.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.70.0_x86_64/vte-0.70.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'aebd8b58c96ce5d224d9a6933d70de94ee62efdd25c9a4862f9f8915431ca930',
     armv7l: 'aebd8b58c96ce5d224d9a6933d70de94ee62efdd25c9a4862f9f8915431ca930',
       i686: '1a6eae251fb5ee84951c448ff8d4b6f2c73f209b70077f1b4cfb07997c4c69be',
     x86_64: 'e75b91643a5550d62f5f3437416d4c8f6702c9b4bbb4276eeee355c1c8b4055d'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'fribidi'
  depends_on 'gtk3'
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
  gnome

  def self.build
    system <<~CONFIGURE
      meson \
      #{CREW_MESON_FNO_LTO_OPTIONS.gsub('-fno-lto', '-fno-lto -fno-stack-protector')} \
      -D_systemd=false \
      -Dfribidi=true \
      -Dgtk3=true \
      -Dgtk4=false \
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
