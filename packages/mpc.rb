require 'package'

class Mpc < Package
  version '1.0.3-cc1.3'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.3/mpc-1.0.3-cc1.3-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/mpc-1.0.3-cc1.3-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.3/mpc-1.0.3-cc1.3-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/mpc-1.0.3-cc1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: 'd1f6e5d521f1807accca245cecf2ccc56c29c96d',
    armv7l:  'd1f6e5d521f1807accca245cecf2ccc56c29c96d',
    i686:    'd7fcd41e92b637220208e136207d1095237f3ac1',
    x86_64:  'fcc7bc8f7a4f9956f801af84e4104e565dd8b285',
  })
end
