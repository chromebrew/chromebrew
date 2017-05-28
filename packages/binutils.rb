require 'package'

class Binutils < Package
  version '2.25-cc1.3'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.3/binutils-2.25-cc1.3-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/binutils-2.25-cc1.3-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.3/binutils-2.25-cc1.3-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/binutils-2.25-cc1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '926b6aeab6d9c33435eefb856e4cb5263753387c',
    armv7l:  '926b6aeab6d9c33435eefb856e4cb5263753387c',
    i686:    'ebf66128ca99fa81c26b49b20163ea77eeb1e204',
    x86_64:  '5427ba83960d0b7866aec8de63415720595ffe4a',
  })
end
