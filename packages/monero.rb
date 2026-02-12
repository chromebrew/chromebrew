require 'package'

class Monero < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.18.4.5'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.27'

  source_url({
    aarch64: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     armv7l: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     x86_64: "https://downloads.getmonero.org/cli/monero-linux-x64-v#{version}.tar.bz2"
  })
  source_sha256({
    aarch64: '42fbcbcf678794d6b104134bb7218093d6aa2764cc9cfa6fad404a4648a7c38a',
     armv7l: '42fbcbcf678794d6b104134bb7218093d6aa2764cc9cfa6fad404a4648a7c38a',
     x86_64: '423b49f3658e29f70a1d971667dec924c7ee7a107cfc93440456e28500b471a6'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/monero"
    FileUtils.mv Dir['monero*'], "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'LICENSE', "#{CREW_DEST_PREFIX}/share/monero"
  end

  def self.postinstall
    ExitMessage.add "\nType 'monero-wallet-cli' to get started.\n"
  end
end
