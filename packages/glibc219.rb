require 'package'

class Glibc219 < Package
  description 'GNU C Library'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.19-2'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.8/glibc-2.19-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/glibc-2.19-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.8/glibc-2.19-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/glibc-2.19-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'df5fb603d658438489bc1d54de317bf8901e2cd3d80a4f3c3379e93cf8539c3c',
    armv7l:  'df5fb603d658438489bc1d54de317bf8901e2cd3d80a4f3c3379e93cf8539c3c',
    i686:    'a7e09144668734a08c660093b4f9ef7b6660c89c027d16eb9db1426f61660d85',
    x86_64:  'bd8a5e69ca2994884bb7cf006887754331faa90e59e6165a693c4392968ccca3',
  })
end
