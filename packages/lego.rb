require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.0.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'c336c624d0daa59fa1ebfc172299ffa69856516ffb038a3a472f33375fd28d15',
     armv7l: 'c336c624d0daa59fa1ebfc172299ffa69856516ffb038a3a472f33375fd28d15',
       i686: 'a79d4682e4eeb0d2edef14f9271d5186c87ee85d03c5eda0efa086984acb11af',
     x86_64: '82a1bf7559f873b7eeb18c8ff98666977e6096e5224fdfeea85db51736045a8b'
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
