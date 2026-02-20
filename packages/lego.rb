require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.32.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '042bec1f9dc1c41c93faa8c025d9be15cfd36afb7ad97a42035c3191d3e5e490',
     armv7l: '042bec1f9dc1c41c93faa8c025d9be15cfd36afb7ad97a42035c3191d3e5e490',
       i686: '65e0048eefcc9e423f6ca19ba39b2771109b3b2ffe912de21ccd865c7a07b8da',
     x86_64: '304c9622cb413e894e0b5c683bda37e23736977c229314384640d8c986e3f330'
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
