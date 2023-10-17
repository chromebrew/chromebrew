require 'package'

class Bitcoin_core < Package
  description 'Bitcoin Core is a full Bitcoin client and builds the backbone of the network.'
  homepage 'https://bitcoin.org/'
  version '25.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://bitcoin.org/bin/bitcoin-core-25.0/bitcoin-25.0-arm-linux-gnueabihf.tar.gz',
     armv7l: 'https://bitcoin.org/bin/bitcoin-core-25.0/bitcoin-25.0-arm-linux-gnueabihf.tar.gz',
     x86_64: 'https://bitcoin.org/bin/bitcoin-core-25.0/bitcoin-25.0-x86_64-linux-gnu.tar.gz'
  })
  source_sha256({
    aarch64: 'e537c8630b05e63242d979c3004f851fd73c2a10b5b4fdbb161788427c7b3c0f',
     armv7l: 'e537c8630b05e63242d979c3004f851fd73c2a10b5b4fdbb161788427c7b3c0f',
     x86_64: '33930d432593e49d58a9bff4c30078823e9af5d98594d2935862788ce8a20aec'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mv 'bin/', CREW_DEST_PREFIX.to_s
    FileUtils.mv 'share/', CREW_DEST_PREFIX.to_s
    FileUtils.mv 'include/', CREW_DEST_PREFIX.to_s
    FileUtils.mv 'bitcoin.conf', "#{CREW_DEST_PREFIX}/etc"
    if ARCH == 'x86_64'
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX.to_s
      FileUtils.mv Dir['lib/*'], CREW_DEST_LIB_PREFIX.to_s
    else
      FileUtils.mv 'lib/', CREW_DEST_PREFIX.to_s
    end
  end
end
