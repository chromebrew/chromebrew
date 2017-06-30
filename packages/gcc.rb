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
  binary_sha256 ({
    aarch64: 'e0bf0855f30aa2084e86b0d382c99b6d15bbc1937f4ea6a993ab06ca1a80bd70',
    armv7l:  'e0bf0855f30aa2084e86b0d382c99b6d15bbc1937f4ea6a993ab06ca1a80bd70',
    i686:    '66a6f4f1b08c1f0f09bc58ccb65b35e48912bf529d1de8452e3e8faeff75bc0c',
    x86_64:  '78cd2fd1a95aee25a9804371118adad78265237718068ed86d90d82e41ca02ce',
  })

  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpc'
  depends_on 'isl'
  depends_on 'cloog'
  depends_on 'glibc'
end
