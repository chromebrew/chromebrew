require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.22.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'e534b88223462779109ec038f6c4d13bd570df822f85e3bd7ef1fb38be2ae3dc',
     armv7l: 'e534b88223462779109ec038f6c4d13bd570df822f85e3bd7ef1fb38be2ae3dc',
       i686: 'add67636c8829c003c0980b0a08c4b2121884dafb1cc802f00e8dcd097d05225',
     x86_64: 'c8cc7fb636f8a5f1167e013dbd01485a72eb7393faf1776664c765a722cd6070'
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
