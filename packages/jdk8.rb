require 'package'

class Jdk8 < Package
  version '1.8.0-112'
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/u/14799278/crew/jdk1.8.0_112-i686.tar.gz",
    x86_64: "https://dl.dropboxusercontent.com/u/14799278/crew/jdk1.8.0_112-x86_64.tar.gz"
  })
  binary_sha1 ({
    i686: "65de377470bdd42e4f3e158b16917166ebe47a02",
    x86_64: "9a009b3b33cbb82ec70e7b0061973b09308c7fed"
  })
end
