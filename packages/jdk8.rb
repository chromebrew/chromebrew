require 'package'

class Jdk8 < Package
  version '8u112'
  binary_url ({
    aarch64: 'https://www.dropbox.com/s/bfu14nhbeoi8tdo/jdk8u111-armv7l.tar.gz?dl=1',
    armv7l:  'https://www.dropbox.com/s/bfu14nhbeoi8tdo/jdk8u111-armv7l.tar.gz?dl=1',
    i686:    'https://dl.dropboxusercontent.com/u/14799278/crew/jdk8u112-i686.tar.gz',
    x86_64:  'https://dl.dropboxusercontent.com/u/14799278/crew/jdk8u112-x86_64.tar.gz',
  })
  binary_sha1 ({
    aarch64: '913adb900bf0d9d42452a4591c1a9093076ed4b6',
    armv7l:  '913adb900bf0d9d42452a4591c1a9093076ed4b6',
    i686:    '65de377470bdd42e4f3e158b16917166ebe47a02',
    x86_64:  '9a009b3b33cbb82ec70e7b0061973b09308c7fed',
  })
end
