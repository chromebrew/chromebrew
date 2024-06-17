require 'package'

class Bitcoin_core < Package
  description 'Bitcoin Core is a full Bitcoin client and builds the backbone of the network.'
  homepage 'https://bitcoincore.org/'
  version '27.1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://bitcoincore.org/bin/bitcoin-core-27.1/bitcoin-27.1-arm-linux-gnueabihf.tar.gz',
     armv7l: 'https://bitcoincore.org/bin/bitcoin-core-27.1/bitcoin-27.1-arm-linux-gnueabihf.tar.gz',
     x86_64: 'https://bitcoincore.org/bin/bitcoin-core-27.1/bitcoin-27.1-x86_64-linux-gnu.tar.gz'
  })
  source_sha256({
    aarch64: '83bf6da65ebac189c7e14f1e68a758b32b8f83558b36b53a8cc8037c674ab045',
     armv7l: '83bf6da65ebac189c7e14f1e68a758b32b8f83558b36b53a8cc8037c674ab045',
     x86_64: 'c9840607d230d65f6938b81deaec0b98fe9cb14c3a41a5b13b2c05d044a48422'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mv 'bin/', CREW_DEST_PREFIX
    FileUtils.mv 'share/', CREW_DEST_PREFIX
    FileUtils.mv 'include/', CREW_DEST_PREFIX
    FileUtils.mv 'bitcoin.conf', "#{CREW_DEST_PREFIX}/etc"
    if ARCH == 'x86_64'
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.mv Dir['lib/*'], CREW_DEST_LIB_PREFIX
    else
      FileUtils.mv 'lib/', CREW_DEST_PREFIX
    end
  end
end
