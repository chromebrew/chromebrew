require 'package'

class Gcc < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '4.9.4'

  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/gcc-4.9.4-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/gcc-4.9.4-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/gcc-4.9.4-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/gcc-4.9.4-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: 'b34938c0ec56dc7bf7c03d4d5596232dede65c53',
    armv7l:  'b34938c0ec56dc7bf7c03d4d5596232dede65c53',
    i686:    '2f18ba781298d4275dd54a339ea415764a4d6fee',
    x86_64:  '4e8e609fafab6ebb527cad7ecabce481c1b419e4',
  })

  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpc'
  depends_on 'isl'
  depends_on 'cloog'
  depends_on 'glibc'
end
