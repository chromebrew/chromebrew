require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.20.4'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '17ad56ca5903e4dad8ae6a27e5fcce12d785f1514562ec90484e61062b1ff426',
     armv7l: '17ad56ca5903e4dad8ae6a27e5fcce12d785f1514562ec90484e61062b1ff426',
       i686: '059cfad6c8a07920b123b1e4138abd6554227a02a8834ade56741d491ac45746',
     x86_64: 'fed2cd32fa0042feda44a4a81d73e76f51d692a779f689d3df8082dcadcc73ba'
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
