require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.31.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '2fb2e4c13f0eb5bc73431a16853d1737de47fd5f4f246c668b9c80693be1173c',
     armv7l: '2fb2e4c13f0eb5bc73431a16853d1737de47fd5f4f246c668b9c80693be1173c',
       i686: 'c3bd723dad9634c968b2ffb18dc30293b48a6cae2ea37431d6d46c192a1d2007',
     x86_64: '3bf525406fee5d31a588f9b278426db972904bf6572e67eba2616f41c2c1b79a'
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
