require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'http://cyan4973.github.io/xxHash/'
  version '0.6.3'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.6.3.tar.gz'
  source_sha256 'd8c739ec666ac2af983a61dc932aaa2a8873df974d333a9922d472a121f2106e'

  binary_url ({
  })
  binary_sha256 ({
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
