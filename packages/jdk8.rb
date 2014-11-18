require 'package'

class Jdk8 < Package
  version '8.0.25'
  binary_url ({
    x86_64: "https://www.dropbox.com/s/jgmiqjpripy7sf9/jdk1.8.0_25_package.tar.gz?dl=0"
  })
  binary_sha1 ({
    x86_64: "601ab66006ade8bbac8dad465cf71aefe5266744"
  })
end




