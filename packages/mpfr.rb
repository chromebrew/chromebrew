require 'package'

class Mpfr < Package
  version '3.1.5-cc1.3'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.3/mpfr-3.1.5-cc1.3-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/mpfr-3.1.5-cc1.3-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.3/mpfr-3.1.5-cc1.3-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/mpfr-3.1.5-cc1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: 'd201c3e9c7fa3d483e93cb967e9ae78b4578868b',
    armv7l:  'd201c3e9c7fa3d483e93cb967e9ae78b4578868b',
    i686:    '71569b4f88e852d0a6734b2be8e200f52248a7fe',
    x86_64:  '7d434ebe762b004d9f822f5baa21b9c9f37452b0',
  })
end
