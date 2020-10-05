require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '1.4.5'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd/archive/v1.4.5.tar.gz'
  source_sha256 '734d1f565c42f691f8420c8d06783ad818060fc390dee43ae0a89f86d0a4f8c2'

  
  def self.build
    system 'make'
  end

  def self.install
    system 'make',
           "DESTDIR=#{CREW_DEST_DIR}",
           "PREFIX=#{CREW_PREFIX}",
           "LIBDIR=#{CREW_LIB_PREFIX}",
           'install'
  end
end
