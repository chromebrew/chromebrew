require 'package'

class Ruby < Package
  version '2.0.0p247-chromeos1'
  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/w4y8b0an136fk3i/ruby-2.0.0p247-chromeos-armv7l.tar.xz",
    i686: "https://dl.dropboxusercontent.com/s/tufbuqcn80ubypx/ruby-2.0.0p247-chromeos-i686.tar.gz&dl=1",
    x86_64: "https://www.dropbox.com/s/x3jt0z5i1r4afyv/ruby-2.0.0p247-chromeos-x86_64.tar.gz?dl=1"
  })
  binary_sha1 ({
    armv7l: "0340b0dfd35e94d634a3f4a5647e13d496aea4e0",
    i686: "49eeba5d542e4c3e6aa3686f215485e0946fb99a",
    x86_64: "f1de1ef5ed690c3b78f4e40208a4fb93e227c4ed"
  })

  depends_on 'readline'
  depends_on 'zlibpkg'
end
