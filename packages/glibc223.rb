require 'package'

class Glibc223 < Package
  description 'GNU C Library'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.23-2'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.8/glibc-2.23-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/glibc-2.23-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.8/glibc-2.23-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/glibc-2.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34755443a25fbe74da7fd4c0d67f758aaf7078db76c45dfa36fdab86a3842266',
    armv7l:  '34755443a25fbe74da7fd4c0d67f758aaf7078db76c45dfa36fdab86a3842266',
    i686:    '14ce3a27fb989a7d26713ebe1c374b9c5f603f6570d99b015dc603223d055f63',
    x86_64:  '151470a91581b26c6b1eaf18aa085c2665aa16eccafb1435040983e1dd8acba0',
  })
end
