require 'package'

class Glibc223 < Package
  description 'GNU C Library'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.23-cc1.3'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.3/glibc-2.23-cc1.3-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/glibc-2.23-cc1.3-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.3/glibc-2.23-cc1.3-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/glibc-2.23-cc1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '09cac401b8d6821c4ea2f349f0a348fcef9e07b2',
    armv7l:  '09cac401b8d6821c4ea2f349f0a348fcef9e07b2',
    i686:    '66096f5bf50ab19f17f8d9356589ea6dc809f8d9',
    x86_64:  '1807e449919fff8d3473d97d43d184961a65a323',
  })
end
