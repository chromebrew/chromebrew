require 'package'

class Cloog < Package
  description 'Chunky Loop Generator which is used to perform optimization in gcc'
  homepage 'https://www.cloog.org/'
  version '0.18.4-2'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.8/cloog-0.18.4-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/cloog-0.18.4-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.8/cloog-0.18.4-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/cloog-0.18.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f79bede55ba092c133a26b03c79b71a4d9e7f46c7118308f9d182f3a2ed3f2c0',
    armv7l:  'f79bede55ba092c133a26b03c79b71a4d9e7f46c7118308f9d182f3a2ed3f2c0',
    i686:    '7bf5c2b4eb9b0d27fe10c4da4315ffb767f22dcc0281803e1f38bfbf6cbb6c74',
    x86_64:  'e5f20db359ef15b7881f0b15f25851a462fc06ccd5e17f23cfc420a6b29b79f6',
  })
end
