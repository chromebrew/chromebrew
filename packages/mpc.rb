require 'package'

class Mpc < Package
  description 'Gnu Mpc is a C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result.'
  homepage 'http://www.multiprecision.org/'
  version '1.0.3-2'
  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew-cross/mpc-1.0.3-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew-cross/mpc-1.0.3-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew-cross/mpc-1.0.3-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew-cross/mpc-1.0.3-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '49795b457852098b34964c768bc4f5fa852c2c40e72f4e856437301f36edb3fd',
     armv7l: '49795b457852098b34964c768bc4f5fa852c2c40e72f4e856437301f36edb3fd',
       i686: 'efec8e5ab8dac926546dabda0ff8b32fe30d85ff2a7c1ab44bdb3d58ad49d19b',
     x86_64: 'b9b26abf315efce1b826f58e70795493d7ed503652486bc3766ac54dfa5d0a35',
  })
end
