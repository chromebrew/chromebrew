require 'package'

class Dartsdk < Package
  version '1.5.3'
  binary_url ({
    i686: 'http://www.appelgriebsch.org/packages/chromeos/dartsdk-1.5.3-chromeos-x86.tar.gz',
    x86_64: 'http://www.appelgriebsch.org/packages/chromeos/dartsdk-1.5.3-chromeos-x86_64.tar.gz'
  })
  binary_sha1 ({
    i686: 'c236b9d5bc7334e38548fade0db9343b6625fae1',
    x86_64: 'c080f51f7c6fd7f9730c83fc30385f894f098c51'
  })
end
