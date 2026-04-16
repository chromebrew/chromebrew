require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.34.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'cb71c99df04ee06b63f066998c7361fb948d091af2f1ad158677882fdaea4300',
     armv7l: 'cb71c99df04ee06b63f066998c7361fb948d091af2f1ad158677882fdaea4300',
       i686: 'd6a397a9bfe852f180d9973cbc0e46cc6b372b925edf5cefaae81fbffb432c87',
     x86_64: 'c681c09d3f2ae37a8d0fe744b55a7d00321832ab603d5bf1b484d66d41b06cd2'
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
