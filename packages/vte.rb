require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  @_ver = '0.64.2'
  version @_ver
  license 'LGPL-2+ and GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/vte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.64.2_armv7l/vte-0.64.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.64.2_armv7l/vte-0.64.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.64.2_x86_64/vte-0.64.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '28d3e1ec594f547221c5a806b89017f4f44817053238a3c75eef000a856c7a29',
     armv7l: '28d3e1ec594f547221c5a806b89017f4f44817053238a3c75eef000a856c7a29',
     x86_64: '3c8d0ddce8365705d966bdc2b1102d77dd660c0265b0e36ff9a7848e400614e0'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'fribidi'
  depends_on 'gtk3'
  depends_on 'gtk4'

  def self.patch
    system "sed -i 's/gtk+-4.0/gtk4/g' meson.build"

    # i686 headers are too old to have TIOCGPTPEER
    case ARCH
    when 'i686'
      system "sed -i 's/#ifdef __linux__/#ifdef TIOCGPTPEER/' src/pty.cc"
    end
  end

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
