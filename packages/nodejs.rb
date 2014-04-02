require 'package'

class Nodejs < Package
  version '5.0.5-2'
  depends_on "xzutils"
  binary_url ({
    i686: 'https://www.archlinux.org/packages/community/i686/nodejs/download/',
    x86_64: 'https://www.archlinux.org/packages/community/x86_64/nodejs/download/'
  })
  binary_sha1 ({
    i686: '64518b6ef5bf2931613bb23aad50bd2a002de365',
    x86_64: '83a6936995129fdd1305bd6caf5107e0ae115359'
  })
end
