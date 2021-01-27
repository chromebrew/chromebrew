require 'package'

class Libxkbcommon < Package
  description 'Keymap handling library for toolkits and window systems'
  homepage 'https://xkbcommon.org'
  @_ver = '1.0.3'
  version @_ver
  compatibility 'all'
  source_url "https://xkbcommon.org/download/libxkbcommon-#{@_ver}.tar.xz"
  source_sha256 'a2202f851e072b84e64a395212cbd976ee18a8ee602008b0bad02a13247dbc52'

  depends_on 'wayland_protocols'
  depends_on 'xkeyboard_config'

  def self.build
    system "meson \
            #{CREW_MESON_LTO_OPTIONS} \
            builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
