require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  @_ver = '0.66.2'
  version @_ver
  license 'LGPL-2+ and GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.66.2_armv7l/vte-0.66.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.66.2_armv7l/vte-0.66.2-chromeos-armv7l.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.66.2_x86_64/vte-0.66.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256({
    aarch64: '3cf89ecf4e12bbf66ee8f9c68937f747404bcfaf66d6398d9e31941d27b8c3d8',
     armv7l: '3cf89ecf4e12bbf66ee8f9c68937f747404bcfaf66d6398d9e31941d27b8c3d8',
     x86_64: 'ddd47d9cff9640670b5fb09ad74a4f674b97f355fb5cc5127c62a47905b67620',
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'fribidi'
  depends_on 'gtk3'

  def self.build
    system <<~CONFIGURE
      meson \
      #{CREW_MESON_FNO_LTO_OPTIONS.gsub('-fno-lto', '-fno-lto -fno-stack-protector')} \
      -Dbuildtype=release \
      -D_systemd=false \
      -Dfribidi=true \
      -Dgtk3=true \
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
