require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.35.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '6662f4201003d99e2c13e2070c0a42c21b94fa7c67d6ee65e42f35825cbfa3df',
     armv7l: '6662f4201003d99e2c13e2070c0a42c21b94fa7c67d6ee65e42f35825cbfa3df',
       i686: '96aece9543ef5f06aca9a798325c23b9826294658346a71fac55921e1e5e21ba',
     x86_64: 'f40ff1f8bdd16c98970f44f748b976b7e30f5ffef2f6faddf9dd65a4c0670c7a'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'lego', "#{CREW_DEST_PREFIX}/bin/lego", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'lego' to get started.\n"
  end
end
