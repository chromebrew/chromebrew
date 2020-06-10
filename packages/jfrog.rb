require 'package'

class Jfrog < Package
  description 'JFrog CLI is a compact and smart client that provides a simple interface that automates access to Artifactory, Bintray and Mission Control through their respective REST APIs.'
  homepage 'https://github.com/JFrogDev/jfrog-cli-go'
  version '1.23.1'
  compatibility 'all'
  source_url 'https://github.com/jfrog/jfrog-cli-go/archive/1.23.1.tar.gz'
  source_sha256 'a5200552acdf55592a6972900f2f658cb25dd6508793bc52fb3386a310a75414'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.23.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.23.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.23.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.23.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2a34fcd0e785f273a6e877e0f157636b58a0677b1785f5a976450c31b4cf3ac5',
     armv7l: '2a34fcd0e785f273a6e877e0f157636b58a0677b1785f5a976450c31b4cf3ac5',
       i686: '4f56688d44178682c7b0edf56a92ccad324ae771a84a562ae019e65f46f4096b',
     x86_64: '7c5bb6f662dc8ea1ae59ad19926d2eab9590ccefd12b131cbc65a5081dbb1ad3',
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
