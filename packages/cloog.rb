require 'package'

class Cloog < Package
  description 'Chunky Loop Generator which is used to perform optimization in gcc'
  homepage 'https://www.cloog.org/'
  version "0.18.4-cc1.3"
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.3/cloog-0.18.4-cc1.3-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/cloog-0.18.4-cc1.3-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.3/cloog-0.18.4-cc1.3-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/cloog-0.18.4-cc1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: 'e54784816f181c185dbd0eddc1b0c9f898db2caa',
    armv7l:  'e54784816f181c185dbd0eddc1b0c9f898db2caa',
    i686:    '3409f9c55e187533308f4febee39651833f592ad',
    x86_64:  'cb29abf230eff44903a9a727f901903cba8bd1c7',
  })
end
