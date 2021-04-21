# Adapted from Arch Linux opus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/opus/trunk/PKGBUILD

require 'package'

class Opus < Package
  description 'Totally open, royalty-free, highly versatile audio codec'
  homepage 'http://opus-codec.org/'
  version '1.3.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz'
  source_sha256 '65b58e1e25b2a114157014736a3d9dfeaad8d41be1c8179866f144a2fb44ff9d'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/opus-1.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/opus-1.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/opus-1.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/opus-1.3.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '028315f0009ee463bfd5379778c05ddac694d78aab4ae8bcc712c87292e18788',
     armv7l: '028315f0009ee463bfd5379778c05ddac694d78aab4ae8bcc712c87292e18788',
       i686: '8e5b85f25823fed5ee6d4f23590931efecb6db3af156ac186a1c04d03e7834d7',
     x86_64: '5300c3c8b5e6072025f118fc82d916a786caaf58d00c2651542561fbd86208ae'
  })

  depends_on 'doxygen' => ':build'

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} \
      --enable-custom-modes"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
