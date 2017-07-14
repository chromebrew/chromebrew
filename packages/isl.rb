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
  binary_sha256 ({
    aarch64: 'f792f6c917c12e8319f00b7a536f974b7040276ded9a00045b91a7cbe0ac61f1',
    armv7l:  'f792f6c917c12e8319f00b7a536f974b7040276ded9a00045b91a7cbe0ac61f1',
    i686:    'eaeb4f965f2e171fd729a111b5525ef31e2a58f67d5cdc68fc5252f1965127ea',
    x86_64:  'a2732f63f643e64c5e75de026c8ef2e339717f249875a762765b750f4691d760',
  })
end
