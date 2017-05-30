require 'package'

class Linuxheaders < Package
  description 'Linux headers for Chrome OS.'
  homepage ''
  version '3.18-cc1.3'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.3/linux-headers-3.18-cc1.3-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/linux-headers-3.18-cc1.3-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.3/linux-headers-3.18-cc1.3-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/linux-headers-3.18-cc1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '4f7c1df409b416735d8d2bfbbc62cb57f3ca5d80',
    armv7l:  '4f7c1df409b416735d8d2bfbbc62cb57f3ca5d80',
    i686:    '0c8190aa192db06772a6d125c1e22ef2ec11e996',
    x86_64:  'aee9c675d1f51268c16273d3ba3bd73334783072',
  })
end
