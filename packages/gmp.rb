require 'package'

class Gmp < Package
  description 'GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.'
  homepage 'https://gmplib.org/'
  version '6.1.2-2'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.8/gmp-6.1.2-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/gmp-6.1.2-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.8/gmp-6.1.2-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/gmp-6.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ec9dd786c7fd0eaf5d2f539ca47d5b050a221e341c3ba23fbbbeedcab437a03',
    armv7l:  '3ec9dd786c7fd0eaf5d2f539ca47d5b050a221e341c3ba23fbbbeedcab437a03',
    i686:    '3b670ac470d2b1d7724f903fde93766ae8c4780b1b61cd4de0a50ec3780529d4',
    x86_64:  'b7cbf53d56f7bb0a3ed36adcafbc340409d2da375560ceaf17102ea4413cebb4',
  })
end
