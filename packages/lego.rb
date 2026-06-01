require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.2.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '0121de262c42eea252ccd19ee493833b29b886b9bfa62d83e2007a2e9bbac1a5',
     armv7l: '0121de262c42eea252ccd19ee493833b29b886b9bfa62d83e2007a2e9bbac1a5',
       i686: '6324fa2f01b518cbf12583e9000e97cbce060353d6288b90b5a4ff8ecdad6990',
     x86_64: 'd985ad6e7a2e8177ae6ac9912b9d080304edf41630803286d952bd355a90dcce'
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
