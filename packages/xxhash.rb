require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'http://cyan4973.github.io/xxHash/'
  version '0.6.4'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.6.4.tar.gz'
  source_sha256 '4570ccd111df6b6386502791397906bf69b7371eb209af7d41debc2f074cdb22'

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
