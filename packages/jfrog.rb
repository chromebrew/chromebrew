require 'package'

class Jfrog < Package
  description 'JFrog CLI is a compact and smart client that provides a simple interface that automates access to Artifactory, Bintray and Mission Control through their respective REST APIs.'
  homepage 'https://github.com/JFrogDev/jfrog-cli-go'
  version '1.11.2'
  source_url 'https://github.com/JFrogDev/jfrog-cli-go/archive/1.11.2.tar.gz'
  source_sha256 'b57f85205097c194d23dae07b225b492839ddf941e0711e7ebdc3e44b13d195d'

  def self.build
    system "bash getCli.sh"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp jfrog #{CREW_DEST_PREFIX}/bin"
  end
end
