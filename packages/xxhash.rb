require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'https://cyan4973.github.io/xxHash/'
  version '0.7.2'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.7.2.tar.gz'
  source_sha256 '7e93d28e81c3e95ff07674a400001d0cdf23b7842d49b211e5582d00d8e3ac3e'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/bin", "#{CREW_DEST_PREFIX}/man/man1"]
    FileUtils.cp 'xxhsum', "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp 'xxhsum.1', "#{CREW_DEST_PREFIX}/man/man1/"
  end
end
