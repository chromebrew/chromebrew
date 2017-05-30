require 'package'

class Gmp < Package
  description 'GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.'
  homepage 'https://gmplib.org/'
  version "6.1.2-cc1.3"
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.3/gmp-6.1.2-cc1.3-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/gmp-6.1.2-cc1.3-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.3/gmp-6.1.2-cc1.3-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/gmp-6.1.2-cc1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '16c62caf6da5971ddb4e4985d5905ce43a40f2f8',
    armv7l:  '16c62caf6da5971ddb4e4985d5905ce43a40f2f8',
    i686:    'eadba1eb5fcc25bdafd1f868045984d726a26d08',
    x86_64:  '706ca2c87011f5ee12324f03ae286fb95a532cec',
  })
end
