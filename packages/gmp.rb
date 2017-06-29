require 'package'

class Gmp < Package
  description 'GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.'
  homepage 'https://gmplib.org/'
  version '6.1.2-1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/gmp-6.1.2-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/gmp-6.1.2-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/gmp-6.1.2-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/gmp-6.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '74c06e1c7fa3b6be68613ba72167416141674a70044452706b9612f6dd4d4267',
    armv7l:  '74c06e1c7fa3b6be68613ba72167416141674a70044452706b9612f6dd4d4267',
    i686:    'd9c8f4c0102d30d17e75c753491c527138ead8238681368e265a58edc8b3ae40',
    x86_64:  '09e6e4a1575da39471e0ae713e54d62dfcb347d913afc3f7f2d49e8489c8d54a',
  })
end
