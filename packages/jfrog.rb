require 'package'

class Jfrog < Package
  description 'JFrog CLI is a compact and smart client that provides a simple interface that automates access to Artifactory, Bintray and Mission Control through their respective REST APIs.'
  homepage 'https://github.com/JFrogDev/jfrog-cli-go'
  version '1.39.5'
  compatibility 'all'
  source_url 'https://github.com/jfrog/jfrog-cli-go/archive/1.39.5.tar.gz'
  source_sha256 '75a0f9bfd3170d03c542b62442761822ff2e4a7a279406d9b2ee5eeee888813f'

  binary_url ({
    
  })
  binary_sha256 ({
    
  })

  depends_on 'go' => :build

  def self.build
    system "git clone https://github.com/jfrog/jfrog-cli-go.git"
    system "cd jfrog-cli-go/jfrog-cli/jfrog/ && git checkout #{version} && go build"
  end

  def self.install
    system "install -Dm755 jfrog-cli-go/jfrog-cli/jfrog/jfrog #{CREW_DEST_PREFIX}/bin/jfrog"
  end
end
