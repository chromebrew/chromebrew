require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.0.3'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '7cecb472547f0b1d0f017327779ac7229c5284f36c99f28878fc79cef1bd0f9c',
     armv7l: '7cecb472547f0b1d0f017327779ac7229c5284f36c99f28878fc79cef1bd0f9c',
       i686: 'e0e6777666c7de6fc66aa5a3b0097c6d826cce1bcfcad04a6d6ba270134badae',
     x86_64: 'b5b3e121001b1cc103fceda4113a9299d8456aaf1d1afbaef094e65c6a22a4dc'
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
