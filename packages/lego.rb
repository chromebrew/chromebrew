require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.8.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '7ffb883f58aa266b529b889985c71c891302b085788723e3a35df5cb4892000a',
     armv7l: '7ffb883f58aa266b529b889985c71c891302b085788723e3a35df5cb4892000a',
       i686: '642899a8053b7ad64d8eb6edcd046842c4dcda08dc6f38eeb16ab05e4a86fbfa',
     x86_64: '5c20c9100f3806fda82309753bf7061a9883b231a34bb9548ee817c9c85b297b'
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
