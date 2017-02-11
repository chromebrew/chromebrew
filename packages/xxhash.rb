require 'package'

class Xxhash < Package
  version '0.6.2'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.6.2.tar.gz'
  source_sha1 '303f93e57b4e1ddc627d62a3313eaab82fd11720'

  def self.build
    system "make"
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_DIR}/usr/local/bin", "#{CREW_DEST_DIR}/usr/local/man/man1"]
    FileUtils.cp "xxhsum", "#{CREW_DEST_DIR}/usr/local/bin/"
    FileUtils.cp "xxhsum.1", "#{CREW_DEST_DIR}/usr/local/man/man1/"
  end
end
