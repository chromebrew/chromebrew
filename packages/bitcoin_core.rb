require 'package'

class Bitcoin_core < Package
  description 'Bitcoin Core is a full Bitcoin client and builds the backbone of the network.'
  homepage 'https://bitcoincore.org/'
  version '28.1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://bitcoincore.org/bin/bitcoin-core-28.1/bitcoin-28.1-arm-linux-gnueabihf.tar.gz',
     armv7l: 'https://bitcoincore.org/bin/bitcoin-core-28.1/bitcoin-28.1-arm-linux-gnueabihf.tar.gz',
     x86_64: 'https://bitcoincore.org/bin/bitcoin-core-28.1/bitcoin-28.1-x86_64-linux-gnu.tar.gz'
  })
  source_sha256({
    aarch64: '6448274420ac632c528bbd4da7198692232cef7bd16d101febc5d05f7d4af1d2',
     armv7l: '6448274420ac632c528bbd4da7198692232cef7bd16d101febc5d05f7d4af1d2',
     x86_64: '07f77afd326639145b9ba9562912b2ad2ccec47b8a305bd075b4f4cb127b7ed7'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mv 'bin/', CREW_DEST_PREFIX
    FileUtils.mv 'share/', CREW_DEST_PREFIX
    FileUtils.mv 'bitcoin.conf', "#{CREW_DEST_PREFIX}/etc"
  end
end
