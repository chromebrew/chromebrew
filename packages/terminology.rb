require 'package'

class Terminology < Package
  description 'Enlightenments terminal emulator'
  homepage 'https://www.enlightenment.org'
  version '1.8.0'
  compatibility 'all'
  source_url 'https://download.enlightenment.org/rel/apps/terminology/terminology-1.8.0.tar.xz'
  source_sha256 'c6f5b003412f25507277702cabe1a11d7190971343c1d6030aa7d3fe5b45765f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/terminology-1.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/terminology-1.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/terminology-1.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/terminology-1.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'be229db30e4c8c423bd89adb118e1e3d7958fe718ca5ecc149bfc395939b0523',
     armv7l: 'be229db30e4c8c423bd89adb118e1e3d7958fe718ca5ecc149bfc395939b0523',
       i686: 'd9d03f10e5522feec35fbb4ea2c789eb805a483403ceafacfc0ab6dcda3c36c6',
     x86_64: '8d975f5df0ff60a90073b858141b042c0b5abe034b84c862b116e4ce0e767fdb',
  })

  depends_on 'desktop_file_utilities'
  depends_on 'xdg_utils'
  depends_on 'libefl'
  depends_on 'sommelier'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} _build"
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
