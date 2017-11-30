require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'http://cyan4973.github.io/xxHash/'
  version '0.6.3'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.6.3.tar.gz'
  source_sha256 'd8c739ec666ac2af983a61dc932aaa2a8873df974d333a9922d472a121f2106e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.6.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.6.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.6.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.6.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2e1ff84aa860e3706752729eee3b625e55e73bd8ab5cf4f6d5f5c9a88aa2a6ac',
     armv7l: '2e1ff84aa860e3706752729eee3b625e55e73bd8ab5cf4f6d5f5c9a88aa2a6ac',
       i686: 'aeee95d5f6d8848bfcad8247bfa5f985ebbda3017b4d49f6748d93a2213b0d47',
     x86_64: '8996d96cc1981728bc2a826f139c0f7b6189d93075e20d7f2cb56cbd4d119a3e',
  })

  def self.build
    system "make", "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/bin", "#{CREW_DEST_PREFIX}/man/man1"]
    FileUtils.cp "xxhsum", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp "xxhsum.1", "#{CREW_DEST_PREFIX}/man/man1/"
  end
end
