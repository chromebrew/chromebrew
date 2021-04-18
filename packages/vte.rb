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
