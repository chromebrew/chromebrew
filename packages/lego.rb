require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.3.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '6be6c7e88323104159157d2312b665c5700ade9dbe246dc2ae277d68eebe91ae',
     armv7l: '6be6c7e88323104159157d2312b665c5700ade9dbe246dc2ae277d68eebe91ae',
       i686: '84de8cae625f52d37b4fe243d84be2721187920ee098303799e8292474ffc831',
     x86_64: 'b3c71b122ee1947eacfe0b809b955647f6377239fe4bfc49f73b1a091ae1252a'
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
