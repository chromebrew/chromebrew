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
  binary_sha1 ({
    aarch64: '275fdba883722c3a0c8dbc92e3fc7d7a5a88bc57',
    armv7l:  '275fdba883722c3a0c8dbc92e3fc7d7a5a88bc57',
    i686:    '19ac6cf905c86c71a4be7773882f742e9786ead9',
    x86_64:  '25586540bc6be6bfa9814ac65b3ee633c452c1b0',
  })
end
