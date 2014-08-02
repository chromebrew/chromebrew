require 'package'

class Nodejs < Package
  version '0.10.29'

  binary_url ({
    i686: 'http://www.appelgriebsch.org/packages/chromeos/nodejs-0.10.29-chromeos-x86.tar.gz',
    x86_64: 'http://www.appelgriebsch.org/packages/chromeos/nodejs-0.10.29-chromeos-x86_64.tar.gz'
  })
  binary_sha1 ({
    i686: 'f2bda846a1928d4218f180878609df3c8c028875',
    x86_64: '07dad5eca9263069234c12ba2047e4905bbac442'
  })
end
