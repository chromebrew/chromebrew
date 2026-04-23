require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.35.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '65d64bb0f2208b63a9c91edc6a0defb088bcc1da36e0bcd277e72fc27d063811',
     armv7l: '65d64bb0f2208b63a9c91edc6a0defb088bcc1da36e0bcd277e72fc27d063811',
       i686: '495d02879cf7974b9b1ca75734813267156b71162f976335659eb605d33a6717',
     x86_64: 'ab7f885fab2d28f70c068cab5ad662a353d5cf31e485f9d040d039a285e1dd6d'
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
