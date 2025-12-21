require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.30.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '42d11acb8954c4cf3d8a7b87dbc3fa720264bd2afc17a0ae6559a534be0744ca',
     armv7l: '42d11acb8954c4cf3d8a7b87dbc3fa720264bd2afc17a0ae6559a534be0744ca',
       i686: '691d8db514c9c7b08cb2f7f169b155b7b349315e8bea3d86615f7d889f4d6a7c',
     x86_64: '39fa1c929feb16d34a2673a6df80e17feddd1060122efd7fd41f9eb7d3f0fc28'
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
