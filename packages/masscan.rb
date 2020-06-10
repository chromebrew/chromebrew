require 'package'

class Masscan < Package
  description 'TCP port scanner, spews SYN packets asynchronously, scanning entire
Internet in under 5 minutes.'
  homepage 'https://github.com/robertdavidgraham/masscan'
  compatibility 'all'
  version '1.0.4'
  source_url 'https://github.com/robertdavidgraham/masscan/archive/1.0.4.tar.gz'
  source_sha256 '51de345f677f46595fc3bd747bfb61bc9ff130adcbec48f3401f8057c8702af9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/masscan-1.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/masscan-1.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/masscan-1.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/masscan-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd1ca6e9300aa9b9fcc416c3c987844eebf614b7a7c49e77bb780d84f2d4c3030',
     armv7l: 'd1ca6e9300aa9b9fcc416c3c987844eebf614b7a7c49e77bb780d84f2d4c3030',
       i686: '2a8c133b95949bb88acd67c3887e23cf8a07f1e81c4ce3d2ec7454ee7268fda8',
     x86_64: '176e98486ebd547ecc7430bf7bb3763352b48d0422bf95d007f9a9dbf3f15de8',
  })

  depends_on 'libpcap'

  def self.build
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp bin/masscan #{CREW_DEST_PREFIX}/bin"
  end
end
