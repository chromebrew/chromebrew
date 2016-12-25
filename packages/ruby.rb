require 'package'

class Ruby < Package
  version '2.0.0p247-chromeos1'
  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/02afb4qm4ugl0os/ruby-2.0.0p247-chromeos-armv7l.tar.xz",
    i686: "https://dl.dropboxusercontent.com/s/tufbuqcn80ubypx/ruby-2.0.0p247-chromeos-i686.tar.gz&dl=1",
    x86_64: "https://www.dropbox.com/s/x3jt0z5i1r4afyv/ruby-2.0.0p247-chromeos-x86_64.tar.gz?dl=1"
  })
  binary_sha1 ({
    armv7l: "f575e27e9b20cbb6f1c77cdd87270748e83cf6b2",
    i686: "49eeba5d542e4c3e6aa3686f215485e0946fb99a",
    x86_64: "f1de1ef5ed690c3b78f4e40208a4fb93e227c4ed"
  })

  depends_on 'readline'
  depends_on 'zlibpkg'
end
