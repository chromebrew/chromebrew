require 'package'

class Jdk8 < Package
  version '8.0.25'
  binary_url ({
    i686: "https://www.dropbox.com/s/d1omw087ilkh5oq/jdk1.8.0_25_i686.tar.gz?dl=0",
    x86_64: "https://www.dropbox.com/s/my0ztzdngrjbsfh/jdk1.8.0_65_x86_64.tar.gz?dl=0"
  })
  binary_sha1 ({
    i686: "2f6fabc6e7b86fa2f21d19f9617d2641c5862a30",
    x86_64: "7701c06a704722b73bf8468a9d7819693e6d4be0"
  })
end
