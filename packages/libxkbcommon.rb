require 'package'

class Libxkbcommon < Package
  description 'Keymap handling library for toolkits and window systems'
  homepage 'http:s//xkbcommon.org'
  version '0.10.0'
  compatibility 'all'
  source_url 'https://xkbcommon.org/download/libxkbcommon-0.10.0.tar.xz'
  source_sha256 '57c3630cdc38fb4734cd57fa349e92244f5ae3862813e533cedbd86721a0b6f2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.10.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.10.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.10.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.10.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '342916012da771abfb4d99034b6f07d11d098e53e250976f173a2f516e5b4f99',
     armv7l: '342916012da771abfb4d99034b6f07d11d098e53e250976f173a2f516e5b4f99',
       i686: '30520eda6f63031b9909870502cad6ea874e2a2858a7c0e9130c2318a81b1bc4',
     x86_64: 'b9ca070f8a5cc0a171f4ae6552e56eb4edf80826efb850d514bd523524da9643',
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
