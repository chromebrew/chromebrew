require 'package'

class Jfrog < Package
  description 'JFrog CLI is a compact and smart client that provides a simple interface that automates access to Artifactory, Bintray and Mission Control through their respective REST APIs.'
  homepage 'https://github.com/JFrogDev/jfrog-cli-go'
  version '1.12.0'
  source_url 'https://github.com/JFrogDev/jfrog-cli-go/archive/1.12.0.tar.gz'
  source_sha256 '8f961f6a6bb79608a8a50ac17f9298633cfd115265ac61f040cda84874336abb'

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
