require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '1.4.8'
  source_url 'https://github.com/behdad/harfbuzz/releases/download/1.4.8/harfbuzz-1.4.8.tar.bz2'
  source_sha256 'ccec4930ff0bb2d0c40aee203075447954b64a8c2695202413cc5e428c907131'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/harfbuzz-1.4.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/harfbuzz-1.4.8-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/harfbuzz-1.4.8-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/harfbuzz-1.4.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ff18bdc0196bbf720b9a39512ddacfbdd78a1bec1d0fa5bedb6ab9d306de0eba',
     armv7l: 'ff18bdc0196bbf720b9a39512ddacfbdd78a1bec1d0fa5bedb6ab9d306de0eba',
       i686: 'ba39ab3fbddef9cf32a60ea03aed0e0ada4d6126e565e30054e2fffa285f6864',
     x86_64: 'ed686080f0d20252a0e82d72eb01a261629ac2fe9a31840e2afcfd8589829dbc',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
