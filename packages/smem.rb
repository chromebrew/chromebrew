require 'package'

class Smem < Package
  description 'A Linux memory reporting tool that uses proportional set size.'
  homepage 'https://www.selenic.com/smem/'
  version '1.4'
  compatibility 'all'
  source_url 'https://www.selenic.com/smem/download/smem-1.4.tar.gz' 
  source_sha256 '2ea9f878f4cf3c276774c3f7e2a41977a1f2d64f98d2dcb6a15f1f3d84df61ec'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/smem-1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/smem-1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/smem-1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/smem-1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '914a30f98944155240bfefd8b4181b06a5b868f2e5949d86c806fe02fecf7c49',
     armv7l: '914a30f98944155240bfefd8b4181b06a5b868f2e5949d86c806fe02fecf7c49',
       i686: 'a971c2ea408330aa01ab3ad1740057d480f6dcbc64f1507e45d33a4f9d82d695',
     x86_64: 'aff43254df620f1dcd080a5071a0f58b223d57b6f48d8545ed453062c115ada6',
  })

  depends_on 'buildessential' => :build
  depends_on 'python27'

  def self.build
    system 'make smemcap'
  end

  def self.install
    system "install -Dm755 smem #{CREW_DEST_PREFIX}/bin/smem"
    system "install -Dm755 smemcap #{CREW_DEST_PREFIX}/bin/smemcap"
    system "install -Dm644 smem.8 #{CREW_DEST_PREFIX}/man/man8/smem.8"
  end
end
