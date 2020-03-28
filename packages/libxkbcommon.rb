require 'package'

class Libxkbcommon < Package
  description 'Keymap handling library for toolkits and window systems'
  homepage 'http:s//xkbcommon.org'
  version '0.10.0'
  source_url 'https://xkbcommon.org/download/libxkbcommon-0.10.0.tar.xz'
  source_sha256 '57c3630cdc38fb4734cd57fa349e92244f5ae3862813e533cedbd86721a0b6f2'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'bison'
  depends_on 'wayland_protocols'
  depends_on 'xkeyboard_config'

  def self.build
    system "pip3 install --prefix #{CREW_PREFIX} -I meson==0.51.1"
    system 'meson',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '_build'
    system 'ninja -v -C _build'
  end

  def self.check
    system 'ninja -C _build test'
    system 'pip3 uninstall meson -y'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
