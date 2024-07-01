require 'package'

class Lego < Package
  description "Let's Encrypt/ACME client and library written in Go"
  homepage 'https://go-acme.github.io/lego/'
  version '4.17.4'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/go-acme/lego/releases/download/v#{version}/lego_v#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'bb5a8a9cd4176c222656701e61b6420bed03294fc88f48a39dc541c229f0b961',
     armv7l: 'bb5a8a9cd4176c222656701e61b6420bed03294fc88f48a39dc541c229f0b961',
       i686: 'b447b44a219334f659bec482e14b52a3f975cbcfe7ab65c0e0be890c6c681282',
     x86_64: 'f362d59ff5b6f92c599e3151dcf7b6ed853de05533be179b306ca40a7b67fb47'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'lego', "#{CREW_DEST_PREFIX}/bin/lego", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'lego' to get started.\n".lightblue
  end
end
