require 'package'

class Monero < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.18.4.0'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.27'

  source_url({
    aarch64: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     armv7l: "https://downloads.getmonero.org/cli/monero-linux-armv7-v#{version}.tar.bz2",
     x86_64: "https://downloads.getmonero.org/cli/monero-linux-x64-v#{version}.tar.bz2"
  })
  source_sha256({
    aarch64: 'b35b5e8d27d799cea6cf3ff539a672125292784739db41181b92a9c73e1c325b',
     armv7l: 'b35b5e8d27d799cea6cf3ff539a672125292784739db41181b92a9c73e1c325b',
     x86_64: '16cb74c899922887827845a41d37c7f3121462792a540843f2fcabcc1603993f'
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
