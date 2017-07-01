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
  binary_sha256 ({
    aarch64: '8a2f8a0059ae27778c51bb949f07b7920bc1e3a5942889c9809558a021296329',
    armv7l:  '8a2f8a0059ae27778c51bb949f07b7920bc1e3a5942889c9809558a021296329',
    i686:    'c30a5f8c45262529953de89309ac6d65546ef3fa57e79a03aaa98f037d18db75',
    x86_64:  '60ce5bb3d89a917aae7fe1e753e221687eb7f7eb28ea2bf05c5cd4a766a510c8',
  })
end
