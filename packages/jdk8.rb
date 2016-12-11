require 'package'

class Jdk8 < Package
  version '1.8.0-112'
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/u/14799278/crew/jdk1.8.0_112-i686.tar.gz",
    x86_64: "https://www.dropbox.com/s/ykw2jt797cpghfy/jdk1.8.0_65_x86_64.tar.gz?dl=0"
  })
  binary_sha1 ({
    i686: "65de377470bdd42e4f3e158b16917166ebe47a02",
    x86_64: "7701c06a704722b73bf8468a9d7819693e6d4be0"
  })
end
