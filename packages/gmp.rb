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
  binary_sha1 ({
    aarch64: '63b9465ad81d2ad68f6b328f1dada69337c4f71e',
    armv7l:  '63b9465ad81d2ad68f6b328f1dada69337c4f71e',
    i686:    '51d647a9a3bd14d0d5f8acbd6f4baf4401e155b4',
    x86_64:  'a69e303b879264de36ca3e075dd3601f77538163',
  })
end
