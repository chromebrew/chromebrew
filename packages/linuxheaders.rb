require 'package'

class Linuxheaders < Package
  description 'Linux headers for Chrome OS.'
  homepage ''
  version '3.18-1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/linux-headers-3.18-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/linux-headers-3.18-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/linux-headers-3.18-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/linux-headers-3.18-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '783acca9a3afe6c77ecd93f10930c779c3d625a5',
    armv7l:  '783acca9a3afe6c77ecd93f10930c779c3d625a5',
    i686:    '965234573d99c99926feb759cdf6e4a70e97c6a0',
    x86_64:  '87a6f22e6f92614279eba518d6e00432c09d8671',
  })
end
