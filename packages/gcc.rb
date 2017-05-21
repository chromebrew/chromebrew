require 'package'

class Gcc < Package
  version '4.9.x-cc1.3'

  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.3/gcc-4.9.x-cc1.3-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/gcc-4.9.x-cc1.3-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.3/gcc-4.9.x-cc1.3-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/gcc-4.9.x-cc1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: 'b71b4f64ff0ab9d32ed15714889046a329b1019c',
    armv7l:  'b71b4f64ff0ab9d32ed15714889046a329b1019c',
    i686:    'a8f9d270d89ba8d9afb4478bf2df1f73ba2878a7',
    x86_64:  'a7da1611b35280117acb0fa86d7d91e0ff6a5e01',
  })

  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpc'
  depends_on 'isl'
  depends_on 'cloog'
  depends_on 'glibc'
end
