require 'package'

class Libxkbcommon < Package
  description 'Keymap handling library for toolkits and window systems'
  homepage 'https://xkbcommon.org'
  @_ver = '1.0.3'
  version @_ver
  compatibility 'all'
  source_url "https://xkbcommon.org/download/libxkbcommon-#{@_ver}.tar.xz"
  source_sha256 'a2202f851e072b84e64a395212cbd976ee18a8ee602008b0bad02a13247dbc52'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-1.0.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-1.0.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-1.0.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '65ba534f892176bd4a2b7255e0083e59c223165219bb976c8b96d8475f54640e',
      armv7l: '65ba534f892176bd4a2b7255e0083e59c223165219bb976c8b96d8475f54640e',
        i686: '945a5a95e0c467dbda2feb0041c6dc004e5242b7416447b75c57465cd2314524',
      x86_64: '8589594e19b3fd9ceca2a8449fe88a9e07d7f20d4525337e532672660cb988ea',
  })

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
