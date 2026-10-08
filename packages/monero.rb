require 'package'

class Monero < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.18.5.3'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.27'

  source_url({
    aarch64: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     armv7l: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     x86_64: "https://downloads.getmonero.org/cli/monero-linux-x64-v#{version}.tar.bz2"
  })
  source_sha256({
    aarch64: '5d902eb7bc445f92ba8b17839e30fbf8a216368b2b4e2376edec6261f73200b1',
     armv7l: '5d902eb7bc445f92ba8b17839e30fbf8a216368b2b4e2376edec6261f73200b1',
     x86_64: '3333d0e04c9cbe3023e7e2b6dd369c407f36bb8df5b05fb0a19d7685b3d56dfc'
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
