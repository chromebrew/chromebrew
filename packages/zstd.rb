require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '1.4.7'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd/archive/v1.4.7.tar.gz'
  source_sha256 '085500c8d0b9c83afbc1dc0d8b4889336ad019eba930c5d6a9c6c86c20c769c8'


  depends_on 'lz4' => ':build'
  
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
