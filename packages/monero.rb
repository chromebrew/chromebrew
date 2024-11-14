require 'package'

class Monero < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.18.3.3'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.27'

  source_url({
    aarch64: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     armv7l: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     x86_64: "https://downloads.getmonero.org/cli/monero-linux-x64-v#{version}.tar.bz2"
  })
  source_sha256({
    aarch64: 'f3f982b141cb6c88939d15a83aaa26334d628c0d2766d6834371030dd00401d3',
     armv7l: 'f3f982b141cb6c88939d15a83aaa26334d628c0d2766d6834371030dd00401d3',
     x86_64: '47c7e6b4b88a57205800a2538065a7874174cd087eedc2526bee1ebcce0cc5e3'
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
    ExitMessage.add "\nType 'monero-wallet-cli' to get started.\n".lightblue
  end
end
