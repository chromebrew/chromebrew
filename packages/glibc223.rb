require 'package'

class Glibc223 < Package
  version '2.23'
  binary_url ({
    armv7l: 'https://github.com/jam7/chromebrew/releases/download/newtoolchains/glibc-2.23-chromeos-armv7l.tar.xz',
    i686:   'https://github.com/jam7/chromebrew/releases/download/newtoolchains/glibc-2.23-chromeos-i686.tar.xz',
    x86_64: 'https://github.com/jam7/chromebrew/releases/download/newtoolchains/glibc-2.23-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    armv7l: '4cac7d5d3d97f147c9ac9ad0c1deb1ac9b967450',
    i686:   '434adb6dd1c3dcc30a25e3700f425a081888a28a',
    x86_64: '9b4ae8c6ccc081f7d9d169cd0b3eb74ae736e79f',
  })
end
