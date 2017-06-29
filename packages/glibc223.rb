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
  binary_sha256 ({
    aarch64: '54cfc66b712bb3a0f5619a90e82db98c34c949e93902cfeb6140da38ed73a19d',
    armv7l:  '54cfc66b712bb3a0f5619a90e82db98c34c949e93902cfeb6140da38ed73a19d',
    i686:    '9a51fe1485eb84b13d4c0fe03839fd9534a48e81c6cb22e845db17a6e711106d',
    x86_64:  '28fd0a4aa514081e1ae098421e47d0172e818e4435b1a2ffd447d4f7cb6799e4',
  })
end
