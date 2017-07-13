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
  binary_sha256 ({
    aarch64: 'd36e27d2edd0819e37b7b95b7d77d42e3f256e7b4bb845325f394b28d6487b4f',
    armv7l:  'd36e27d2edd0819e37b7b95b7d77d42e3f256e7b4bb845325f394b28d6487b4f',
    i686:    'fd44ecb2f021cf8ced4e46b1579a0f1a27bc553f41a077745394056afaa3d808',
    x86_64:  'cf8f4db6a406ef2d59701902d5981dd864a834ced50e9832d6856174e4271f7d',
  })
end
