require 'package'

class Jfrog < Package
  description 'JFrog CLI is a compact and smart client that provides a simple interface that automates access to Artifactory, Bintray and Mission Control through their respective REST APIs.'
  homepage 'https://github.com/JFrogDev/jfrog-cli-go'
  version '1.39.5'
  compatibility 'all'
  source_url 'https://github.com/jfrog/jfrog-cli-go/archive/1.39.5.tar.gz'
  source_sha256 '75a0f9bfd3170d03c542b62442761822ff2e4a7a279406d9b2ee5eeee888813f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.39.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.39.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.39.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.39.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4561d7c7fe855a92055e23baee586f25b0261fce20f89919c12ca477e0895324',
     armv7l: '4561d7c7fe855a92055e23baee586f25b0261fce20f89919c12ca477e0895324',
       i686: 'a9e442aaa7c27b21256b8fc43d8f14b97ab3b65efa247812f5fb20ed57cbf028',
     x86_64: '260c9a12692b2942cba44748dd5bdc72efbf377064ddd242db4100bff4a175ca',
  })

  depends_on 'go' => :build

  def self.build
    system "git clone https://github.com/jfrog/jfrog-cli-go.git"
    system "cd jfrog-cli-go && git checkout #{version} && build/build.sh"
  end

  def self.install
    system "install -Dm755 jfrog-cli-go/jfrog #{CREW_DEST_PREFIX}/bin/jfrog"
  end
end
