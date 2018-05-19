require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '1.3.4'
  source_url 'https://github.com/facebook/zstd/archive/master.tar.gz'
  source_sha256 '7fba0070789a3c1e343fab4660958b73cc262110d2977589ba158b169d331ad6'
  
  def self.build
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
