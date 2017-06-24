require 'package'

class Glibc223 < Package
  description 'GNU C Library'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.23-1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/glibc-2.23-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/glibc-2.23-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/glibc-2.23-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/glibc-2.23-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '0fecd72cda0d24833750553015e88fb6624e62a3',
    armv7l:  '0fecd72cda0d24833750553015e88fb6624e62a3',
    i686:    '5260ed2243ca382c5fd780f3833a0d39b519f1fc',
    x86_64:  '57e08745e97f79a49283847c92ac5164072db14c',
  })
end
