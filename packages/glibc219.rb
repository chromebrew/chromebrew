require 'package'

class Glibc219 < Package
  description 'GNU C Library'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.19-1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/glibc-2.19-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/glibc-2.19-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/glibc-2.19-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/glibc-2.19-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '4e318b8250d90a52d0f19963be60de41a8eccba4',
    armv7l:  '4e318b8250d90a52d0f19963be60de41a8eccba4',
    i686:    '156c2b7bcb0ed9f8604d0a91908871648c55e260',
    x86_64:  'e094f717ec2f5add484994a8537903fa0d07d7f8',
  })
end
