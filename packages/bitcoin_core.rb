require 'package'

class Bitcoin_core < Package
  description 'Bitcoin Core is a full Bitcoin client and builds the backbone of the network.'
  homepage 'https://bitcoincore.org/'
  version '28.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://bitcoincore.org/bin/bitcoin-core-28.0/bitcoin-28.0-arm-linux-gnueabihf.tar.gz',
     armv7l: 'https://bitcoincore.org/bin/bitcoin-core-28.0/bitcoin-28.0-arm-linux-gnueabihf.tar.gz',
     x86_64: 'https://bitcoincore.org/bin/bitcoin-core-28.0/bitcoin-28.0-x86_64-linux-gnu.tar.gz'
  })
  source_sha256({
    aarch64: 'e004b7910bedd6dd18b6c52b4eef398d55971da666487a82cd48708d2879727e',
     armv7l: 'e004b7910bedd6dd18b6c52b4eef398d55971da666487a82cd48708d2879727e',
     x86_64: '7fe294b02b25b51acb8e8e0a0eb5af6bbafa7cd0c5b0e5fcbb61263104a82fbc'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mv 'bin/', CREW_DEST_PREFIX
    FileUtils.mv 'share/', CREW_DEST_PREFIX
    FileUtils.mv 'bitcoin.conf', "#{CREW_DEST_PREFIX}/etc"
  end
end
