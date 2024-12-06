require 'package'

class Nushell < Package
  description 'A new type of shell'
  homepage 'https://www.nushell.sh/'
  version '0.100.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     x86_64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'adca26d894b0b3ca30adb06f180d6d7e57c39b76d1802ba4d59225bf7f1e7fec',
     armv7l: 'adca26d894b0b3ca30adb06f180d6d7e57c39b76d1802ba4d59225bf7f1e7fec',
     x86_64: '7bcd2c64bc7028f8cdbb25f2f84d61b3c9418ce6c39e13c7f010d412f1e8711e'
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
