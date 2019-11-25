require 'package'

class Libxkbcommon < Package
  description 'Keymap handling library for toolkits and window systems'
  homepage 'http:s//xkbcommon.org'
  version '0.9.1'
  source_url 'https://xkbcommon.org/download/libxkbcommon-0.9.1.tar.xz'
  source_sha256 'd4c6aabf0a5c1fc616f8a6a65c8a818c03773b9a87da9fbc434da5acd1199be0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '92f859886c013e1e4d707c9ba5f8c24416ef90176f8c890a6bd695dc5c963072',
     armv7l: '92f859886c013e1e4d707c9ba5f8c24416ef90176f8c890a6bd695dc5c963072',
       i686: 'e829130c0953c012a04605ec8b81f96efc151834dd39dc76a161c373698615b9',
     x86_64: 'ebc0379107a731b6077e8a6d6ae5d1a002671f34048c4e31423a69fcf55f6644',
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
