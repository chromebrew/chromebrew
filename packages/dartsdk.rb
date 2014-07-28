require 'package'

class Dartsdk < Package
  version '1.5.3'
  binary_url ({
    i686: 'http://www.appelgriebsch.org/packages/chromeos/dartsdk-1.5.3-chromeos-x86.tar.gz',
    x86_64: 'http://www.appelgriebsch.org/packages/chromeos/dartsdk-1.5.3-chromeos-x86_64.tar.gz'
  })
  binary_sha1 ({
    i686: '9a849e5c328b3eefc3ef72434d89b55c7c54750f',
    x86_64: 'c46b94e78cb1d68ccb1e712c73544e382c84dc15'
  })
end
