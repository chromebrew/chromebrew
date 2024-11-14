require 'package'

class Nushell < Package
  description 'A new type of shell'
  homepage 'https://www.nushell.sh/'
  version '0.99.1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     x86_64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '68cc9d9de1b6015e646199bc3806f61b7bd228ac345d62b521d328902a883c17',
     armv7l: '68cc9d9de1b6015e646199bc3806f61b7bd228ac345d62b521d328902a883c17',
     x86_64: '3aeb6b790414e29296097790074f2e03db29b0aba329306e3ffdbfefa3e2664f'
  })

  no_compile_needed
  no_shrink

  def self.install
    Dir['nu*'].each do |bin|
      FileUtils.install bin, "#{CREW_DEST_PREFIX}/bin/#{bin}", mode: 0o755
    end
  end

  def self.postinstall
    puts "\nType 'nu' to get started.\n".lightblue
  end
end
