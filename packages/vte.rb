require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  @_ver = '0.64.0'
  version @_ver
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/vte/#{@_ver.rpartition('.')[0]}/vte-#{@_ver}.tar.xz"
  source_sha256 'c0c60b8dc343167437c86d984b0cf134df86034180ed70513f683006ada3ec41'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.64.0_armv7l/vte-0.64.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.64.0_armv7l/vte-0.64.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.64.0_i686/vte-0.64.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vte/0.64.0_x86_64/vte-0.64.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c29af253aa820f21b91be681e8fa1bdd2e5d0028455827b38f281738f13a3a09',
     armv7l: 'c29af253aa820f21b91be681e8fa1bdd2e5d0028455827b38f281738f13a3a09',
       i686: '610c54d224b4e63bac35107f78089d625120e3f16cc8dda217172093e63a4eb3',
     x86_64: '1e7a6e0496eac016b8343df2a4e2ead78eb1125587d2ce2169a03f35a688a201'
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
