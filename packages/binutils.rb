require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'http://www.gnu.org/software/binutils/'
  version '2.25-2'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/binutils-2.25-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/binutils-2.25-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/binutils-2.25-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/binutils-2.25-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a6edb738fa8b65374b0ad087537fa0649ba59af6bb7ddc83eca06d504f1c2a45',
    armv7l:  'a6edb738fa8b65374b0ad087537fa0649ba59af6bb7ddc83eca06d504f1c2a45',
    i686:    '214ae25a910f56ff379620933defd497697f37f693c5b54dd34fb3b8b4f286dc',
    x86_64:  '1c00d036d95a5255dd35dfdb9c934f2b9ae2d73f6788831e60a3ab12e5c1f354',
  })
end
