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
  binary_sha256 ({
    aarch64: '7524d818571059970caece1b4616d947c4937a591383ed5644636c45d9c16bdd',
    armv7l:  '7524d818571059970caece1b4616d947c4937a591383ed5644636c45d9c16bdd',
    i686:    'b9eb79ec3bfe59c85b7520673cbd5eb24414a176e040fca9a5fb57e82e4dd28e',
    x86_64:  '173200b006598bc46c964531a87ffde6cae1656759d5f96c54bc73b322e0af46',
  })
end
