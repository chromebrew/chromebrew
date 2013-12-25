require 'package'

class Ruby < Package
  version '2.0.0p247-chromeos1'
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/s/tufbuqcn80ubypx/ruby-2.0.0p247-chromeos-i686.tar.gz?token_hash=AAGu_5wuqZe2eDOkfL5oh4esQ8HAZJIvbMG7GplnQrSa3g&dl=1",
    x86_64: "https://dl.dropboxusercontent.com/s/bwb315aluunam6b/ruby-2.0.0-p247-chromeos1-chromeos-x86_86.tar.gz?token_hash=AAGYQhHhEpgAHCKtVVonVlXIJKZOWzq3arNsirxcRJQgLA&dl=1"
  })
  binary_sha1 ({
    i686: "49eeba5d542e4c3e6aa3686f215485e0946fb99a",
    x86_64: "ec4d9c9d1a993ca03d0dee594c79ab1945e5b88d"
  })

  depends_on 'readline'
  depends_on 'zlibpkg'
end
