require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '1.3.4'
  source_url 'https://github.com/facebook/zstd/archive/v1.3.4.tar.gz'
  source_sha256 '92e41b6e8dd26bbd46248e8aa1d86f1551bc221a796277ae9362954f26d605a9'
  
  def self.build
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", "install"
  end
end
