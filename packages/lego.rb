require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.33.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'aa17899ae0bf46ceec32362d0b6962629e6f9dbc5de6f511f57ea8f321668247',
     armv7l: 'aa17899ae0bf46ceec32362d0b6962629e6f9dbc5de6f511f57ea8f321668247',
       i686: '6cf735889e6983ee9d3e89c7e8e2d261dbcc9ae76540040f25d31b7cdc73aa47',
     x86_64: 'ad9774e26038bfc48ebafd4430e6412b7fc09ab91809f7f4841a49043ef37aee'
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
