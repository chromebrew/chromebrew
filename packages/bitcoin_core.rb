require 'package'

class Bitcoin_core < Package
  description 'Bitcoin Core is a full Bitcoin client and builds the backbone of the network.'
  homepage 'https://bitcoincore.org/'
  version '25.1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://bitcoincore.org/bin/bitcoin-core-25.1/bitcoin-25.1-arm-linux-gnueabihf.tar.gz',
     armv7l: 'https://bitcoincore.org/bin/bitcoin-core-25.1/bitcoin-25.1-arm-linux-gnueabihf.tar.gz',
     x86_64: 'https://bitcoincore.org/bin/bitcoin-core-25.1/bitcoin-25.1-x86_64-linux-gnu.tar.gz'
  })
  source_sha256({
    aarch64: '28b8811984e215d9dc42536394629029edc1d15ab896f007d54d1d42a343f9db',
     armv7l: '28b8811984e215d9dc42536394629029edc1d15ab896f007d54d1d42a343f9db',
     x86_64: 'a978c407b497a727f0444156e397b50491ce862d1f906fef9b521415b3611c8b'
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
