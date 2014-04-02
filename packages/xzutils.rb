require 'package'

class Xzutils < Package
  version '5.0.5-2'
  binary_url ({
    i686: 'https://www.archlinux.org/packages/core/i686/xz/download/',
    x86_64: 'https://www.archlinux.org/packages/core/x86_64/xz/download/'
  })
  binary_sha1 ({
    i686: 'f1111f4a3be03f5bd2a11a8975c28bbd72ee32fa',
    x86_64: '7ec149add03f049f855c112db7f990e946a592ab'
  })
end
