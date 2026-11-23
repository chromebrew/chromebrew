require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '5.7.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '38aa5e06d36f8aeaa45e40a7a5346fe566ac2445c1bdf4567a3f0aa7759eef01',
     armv7l: '38aa5e06d36f8aeaa45e40a7a5346fe566ac2445c1bdf4567a3f0aa7759eef01',
       i686: '51c110d380e4c4479b3ec03b1783718eefa50709900b3537a6c828fac3498235',
     x86_64: 'ffc7f0d75810a70affffb10fc20a8db4d6dd4917f8f88cda9b54fb08c82a1967'
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
