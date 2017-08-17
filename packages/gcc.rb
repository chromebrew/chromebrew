require 'package'

class Gcc < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '4.9.4-1'

  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.8/gcc-4.9.4-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/gcc-4.9.4-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.8/gcc-4.9.4-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/gcc-4.9.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ecb047a9f52ea6b24313d4329b00236b6880e12df684e52e34e9664127d447c6',
    armv7l:  'ecb047a9f52ea6b24313d4329b00236b6880e12df684e52e34e9664127d447c6',
    i686:    '9a8b20b58a564c9557c74b2b2769ddc68c110211588356b71c533aac6d54431b',
    x86_64:  '1ae1f58ca4b9fee3b0f68856e5d49b2feeb90e259e8d885f339c9aa8091f27c8',
  })

  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpc'
  depends_on 'isl'
  depends_on 'cloog'
  depends_on 'glibc'
end
