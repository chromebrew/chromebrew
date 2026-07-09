require 'package'

class Monero < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.18.5.1'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.27'

  source_url({
    aarch64: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     armv7l: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     x86_64: "https://downloads.getmonero.org/cli/monero-linux-x64-v#{version}.tar.bz2"
  })
  source_sha256({
    aarch64: 'bd6693ac411919d474d98c9e7d7bae1f03e7ef7f1d779a15e2ba3a188c958d36',
     armv7l: 'bd6693ac411919d474d98c9e7d7bae1f03e7ef7f1d779a15e2ba3a188c958d36',
     x86_64: '22a7dda7b0cb699fdd6b7674c3b4a4465b337cc98a54983523b759e1e7cc9958'
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
