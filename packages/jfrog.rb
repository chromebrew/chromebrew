require 'package'

class Jfrog < Package
  description 'JFrog CLI is a compact and smart client that provides a simple interface that automates access to Artifactory, Bintray and Mission Control through their respective REST APIs.'
  homepage 'https://github.com/JFrogDev/jfrog-cli-go'
  version '1.12.0'
  source_url 'https://github.com/JFrogDev/jfrog-cli-go/archive/1.12.0.tar.gz'
  source_sha256 '8f961f6a6bb79608a8a50ac17f9298633cfd115265ac61f040cda84874336abb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.12.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.12.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jfrog-1.12.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f4c4ab9916d827cb543a683cd6ae6ef49a8c7c809b6288f36a18caceefe436f',
     armv7l: '8f4c4ab9916d827cb543a683cd6ae6ef49a8c7c809b6288f36a18caceefe436f',
       i686: '44c977eb46708202359d1a495e99a5eee0f1e1725b26036790eb1a3cc89c779b',
     x86_64: '19ce3e127f359ff9054ce48b8f879676c3d968789203719a27823e913164c056',
  })

  depends_on 'go' => :build

  def self.install
    system "SAVEGOPATH=$GOPATH && \
            export GOPATH=#{CREW_DEST_PREFIX}/share/jfrog && \
            go get -v github.com/jfrogdev/jfrog-cli-go/jfrog-cli/jfrog && \
            export GOPATH=$SAVEGOPATH"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "ln -s #{CREW_PREFIX}/share/jfrog/bin/jfrog jfrog"
    end
    system "rm -rf #{CREW_DEST_PREFIX}/share/jfrog/pkg"
    system "rm -rf #{CREW_DEST_PREFIX}/share/jfrog/src"
  end
end
