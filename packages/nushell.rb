require 'package'

class Nushell < Package
  description 'A new type of shell'
  homepage 'https://www.nushell.sh/'
  version '0.101.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     x86_64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '016052987cbe7aea796b12390c70786ed000f75089b93819aaa1bd61f60fddae',
     armv7l: '016052987cbe7aea796b12390c70786ed000f75089b93819aaa1bd61f60fddae',
     x86_64: '7149728c779b5d7e7f86e34f36fd31332f7677df3e9a47b5744a1e1756d3ce76'
  })

  no_compile_needed
  no_shrink

  def self.install
    Dir['nu*'].each do |bin|
      FileUtils.install bin, "#{CREW_DEST_PREFIX}/bin/#{bin}", mode: 0o755
    end
  end

  def self.postinstall
    ExitMessage.add "\nType 'nu' to get started.\n"
  end
end
