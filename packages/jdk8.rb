require 'package'

class Jdk8 < Package
  version '8.0.25'
  binary_url ({
    i686: "https://www.dropbox.com/s/d1omw087ilkh5oq/jdk1.8.0_25_i686.tar.gz?dl=0",
    x86_64: "https://www.dropbox.com/s/j1p2fbof5ms2wob/jdk1.8.0_25_i686.tar.gz?dl=0"
  })
  binary_sha1 ({
    i686: "2f6fabc6e7b86fa2f21d19f9617d2641c5862a30",
    x86_64: "2f6fabc6e7b86fa2f21d19f9617d2641c5862a30"
  })
end
