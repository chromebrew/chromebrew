require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  @_ver = '0.67.90'
  version @_ver
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.67.90_armv7l/vte-0.67.90-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.67.90_armv7l/vte-0.67.90-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.67.90_i686/vte-0.67.90-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.67.90_x86_64/vte-0.67.90-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dcfdd849cf41e7eebdbf4898736f3a4a4110bce26bdfb46fb8b2e2ed6abca976',
     armv7l: 'dcfdd849cf41e7eebdbf4898736f3a4a4110bce26bdfb46fb8b2e2ed6abca976',
       i686: 'df376361939b8573ab907b9a2be807c1086bf37b9979829153d8f73194ca3fa4',
     x86_64: '646cc0968db68d6db74c294a134ad05a1b3b04af0661416b0f19997e6492867b'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'fribidi'
  depends_on 'gtk3'

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
