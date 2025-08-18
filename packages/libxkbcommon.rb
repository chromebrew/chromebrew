require 'package'

class Libxkbcommon < Package
  description 'Keymap handling library for toolkits and window systems'
  homepage 'https://xkbcommon.org'
  version '1.11.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://xkbcommon.org/download/libxkbcommon-#{version}.tar.xz"
  source_sha256 'b620507312c5e97566a3c6cfaf99144fefc18a0da7d941401dfa0f5f58fb0368'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65ba534f892176bd4a2b7255e0083e59c223165219bb976c8b96d8475f54640e',
     armv7l: '65ba534f892176bd4a2b7255e0083e59c223165219bb976c8b96d8475f54640e',
     x86_64: '8589594e19b3fd9ceca2a8449fe88a9e07d7f20d4525337e532672660cb988ea'
  })

  depends_on 'wayland_protocols'
  depends_on 'xkeyboard_config'

  def self.build
    system "meson \
            #{CREW_MESON_OPTIONS} \
            builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
