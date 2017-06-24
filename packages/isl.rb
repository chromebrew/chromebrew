require 'package'

class Isl < Package
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'http://isl.gforge.inria.fr/'
  version '0.18'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/isl-0.18-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/isl-0.18-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/isl-0.18-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/isl-0.18-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: 'c954cc42a2129cd179ec1554c8c0bb66ea1ff242',
    armv7l:  'c954cc42a2129cd179ec1554c8c0bb66ea1ff242',
    i686:    'ffd99eb6b19cd83856a58c10bbc55a634c37e520',
    x86_64:  '56e335db9d66b91d0943fe1597b20eb23d05bc94',
  })
end
