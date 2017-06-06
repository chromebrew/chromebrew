require 'package'

class Isl < Package
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'http://isl.gforge.inria.fr/'
  version "0.14.1-cc1.3"
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.3/isl-0.14.1-cc1.3-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/isl-0.14.1-cc1.3-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.3/isl-0.14.1-cc1.3-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.3/isl-0.14.1-cc1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '749bf7d0a09c1578ce2de20a21ce7f7d6a575756',
    armv7l:  '749bf7d0a09c1578ce2de20a21ce7f7d6a575756',
    i686:    '306c249734107ac29e7951a44a000cfcbb523a35',
    x86_64:  '7e0dcb1c65a99be666c4369abb649ad27f88ade1',
  })
end
