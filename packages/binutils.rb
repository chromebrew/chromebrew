require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'http://www.gnu.org/software/binutils/'
  version '2.25-3'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.8/binutils-2.25-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/binutils-2.25-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.8/binutils-2.25-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.8/binutils-2.25-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1bacd0d559775a5e8c444ccb51e75158abc4b997a206756bee2414d83f60381d',
    armv7l:  '1bacd0d559775a5e8c444ccb51e75158abc4b997a206756bee2414d83f60381d',
    i686:    '0e633732a1b4c4ca0eb7d5e7bdb69e3dc027c398caa1ad940b0bceb5a067a371',
    x86_64:  '98f6862f011ba38d192c8dac80f45af667832b850dc85f73959548a2a251bd44',
  })
end
