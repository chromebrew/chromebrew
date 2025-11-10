require 'package'

class Monero < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.18.4.3'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.27'

  source_url({
    aarch64: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     armv7l: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     x86_64: "https://downloads.getmonero.org/cli/monero-linux-x64-v#{version}.tar.bz2"
  })
  source_sha256({
    aarch64: '3ac83049bc565fb5238501f0fa629cdd473bbe94d5fb815088af8e6ff1d761cd',
     armv7l: '3ac83049bc565fb5238501f0fa629cdd473bbe94d5fb815088af8e6ff1d761cd',
     x86_64: '3a7b36ae4da831a4e9913e0a891728f4c43cd320f9b136cdb6686b1d0a33fafa'
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
