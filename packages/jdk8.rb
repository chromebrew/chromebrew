require 'package'

class Jdk8 < Package
  version '8.0.91'
  binary_url ({
    i686: "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-i586.tar.gz",
    x86_64: "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz"
  })
  binary_sha2 ({
    i686: "5ecd05b5e566cbe688fc1e3159f04004ccad14d4faa3f50d15ffba1d50b4cd52",
    x86_64: "6f9b516addfc22907787896517e400a62f35e0de4a7b4d864b26b61dbe1b7552"
  })
end
