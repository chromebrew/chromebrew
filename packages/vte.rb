require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  @_ver = '0.69.92'
  version @_ver
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.69.92_armv7l/vte-0.69.92-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.69.92_armv7l/vte-0.69.92-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.69.92_i686/vte-0.69.92-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.69.92_x86_64/vte-0.69.92-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c7b015afc564f5ca0f50328ca1ae8f1e27bbc8d9f5d389feb783f9d36986e9d7',
     armv7l: 'c7b015afc564f5ca0f50328ca1ae8f1e27bbc8d9f5d389feb783f9d36986e9d7',
       i686: '9f6840aeb382b7bfcdf089f2f50aa3edfe9993c6c657bc6e9c87b9256f0d27f8',
     x86_64: 'e3958e79e715ca4b03fbb25c03bb728db4c0c7f92e97b57dba62410c18979546'
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
