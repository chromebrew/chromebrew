require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.6.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '2cf63a16f080556e9b03c2b8aa049eabe9c986e65d46270726f86d5a376ef1b5',
     armv7l: '2cf63a16f080556e9b03c2b8aa049eabe9c986e65d46270726f86d5a376ef1b5',
       i686: '1e34109520ddc7c9cf0c269108d7a39e922ff40f394addd8f44682a2e7cfe3ed',
     x86_64: 'f02fc11b6f56b97e387fa7caa0268f86f5a336953b22458e6430e4651fea439a'
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
