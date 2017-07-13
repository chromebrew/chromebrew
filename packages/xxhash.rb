require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'http://cyan4973.github.io/xxHash/'
  version '0.6.2'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.6.2.tar.gz'
  source_sha256 'e4da793acbe411e7572124f958fa53b280e5f1821a8bf78d79ace972950b8f82'

  def self.build
    system "make"
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_DIR}/usr/local/bin", "#{CREW_DEST_DIR}/usr/local/man/man1"]
    FileUtils.cp "xxhsum", "#{CREW_DEST_DIR}/usr/local/bin/"
    FileUtils.cp "xxhsum.1", "#{CREW_DEST_DIR}/usr/local/man/man1/"
  end
end
