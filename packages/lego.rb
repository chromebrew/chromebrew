require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.4.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '3e0c223591fe79d0085bd45a7859125d2881b77b517a0c1c36cde14b0d41bad9',
     armv7l: '3e0c223591fe79d0085bd45a7859125d2881b77b517a0c1c36cde14b0d41bad9',
       i686: 'fae7fc81ead9a38eabdd8a3c7fcbf9c7a62d23029e9df3d628b27f901cf6eb20',
     x86_64: 'd3adf89392d606ce84d485c1cc20832edd42ace6ff9ced9dd3670d9d8b8aca38'
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
