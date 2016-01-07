require 'package'

class Ruby < Package
  version '2.0.0p247-chromeos1'
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/s/tufbuqcn80ubypx/ruby-2.0.0p247-chromeos-i686.tar.gz?token_hash=AAGu_5wuqZe2eDOkfL5oh4esQ8HAZJIvbMG7GplnQrSa3g&dl=1",
    x86_64: "https://www.dropbox.com/s/x3jt0z5i1r4afyv/ruby-2.0.0p247-chromeos-x86_64.tar.gz?dl=1"
  })
  binary_sha1 ({
    i686: "49eeba5d542e4c3e6aa3686f215485e0946fb99a",
    x86_64: "f1de1ef5ed690c3b78f4e40208a4fb93e227c4ed"
  })

  depends_on 'readline'
  depends_on 'zlibpkg'
end
