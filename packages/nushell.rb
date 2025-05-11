require 'package'

class Nushell < Package
  description 'A new type of shell'
  homepage 'https://www.nushell.sh/'
  version '0.104.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     x86_64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '58f4a1ed6d8c4b4c3800b1a6273dedeba4bd115f587a5b2812caa43356752d18',
     armv7l: '58f4a1ed6d8c4b4c3800b1a6273dedeba4bd115f587a5b2812caa43356752d18',
     x86_64: 'ad72e032e266f4a75803dd92b63dbeb5d9a68a33a3c713336f8a24c740fdc9b6'
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
