require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'https://cyan4973.github.io/xxHash/'
  version '0.7.3'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.7.3.tar.gz'
  source_sha256 '952ebbf5b11fbf59ae5d760a562d1e9112278f244340ad7714e8556cbe54f7f7'

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
