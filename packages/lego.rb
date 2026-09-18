require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.5.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '04e65f67d572bb609c6c6e749533c683a2cfced1a77526b95087cfbb22ebcf81',
     armv7l: '04e65f67d572bb609c6c6e749533c683a2cfced1a77526b95087cfbb22ebcf81',
       i686: '43a9ae1f170a110e08b5173caa541793e7d0ce83c8b6f3f5dca2c5df8d555b74',
     x86_64: '1f4daa9ba7c98986864bc5d4c1b599ae64ccada8a27c8ae146b3d201e7b32744'
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
