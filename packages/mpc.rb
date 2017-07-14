require 'package'

class Mpc < Package
  description 'Gnu Mpc is a C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result.'
  homepage 'http://www.multiprecision.org/'
  version '1.0.3-1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/mpc-1.0.3-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/mpc-1.0.3-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/mpc-1.0.3-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/mpc-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '58518e1b1a26d4c48e101bea2d42c640b9dccdd0300fbda9cce9635dbdbfa4ba',
    armv7l:  '58518e1b1a26d4c48e101bea2d42c640b9dccdd0300fbda9cce9635dbdbfa4ba',
    i686:    'ac2789b514e0b581c619a197d8e7cecae1bfc3c5251a9a9bb857d4a78d03ca1e',
    x86_64:  '6c39fe899b348b693736a662bd19168ffea70718533942b35491d7df0a4a2d35',
  })
end
