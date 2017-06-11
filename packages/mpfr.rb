require 'package'

class Mpfr < Package
  description 'The MPFR library is a C library for multiple-precision floating-point computations with correct rounding.'
  homepage 'http://www.mpfr.org/'
  version '3.1.5-1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/mpfr-3.1.5-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/mpfr-3.1.5-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/mpfr-3.1.5-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/mpfr-3.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: 'e388055aa9652e2c0c580f0e0cc26509d8c17f39',
    armv7l:  'e388055aa9652e2c0c580f0e0cc26509d8c17f39',
    i686:    '87630dd77fbdad79f0382e64a9ddb82453d21a46',
    x86_64:  '6e137ee58ceca44fbc9bd0f35a2039993f7a0cc1',
  })
end
