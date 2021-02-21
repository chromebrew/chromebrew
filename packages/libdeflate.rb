require 'package'

class Libdeflate < Package
  description 'Heavily optimized library for DEFLATE compression and decompression'
  homepage 'https://github.com/ebiggers/libdeflate/'
  version '1.7'
  compatibility 'all'
  source_url 'https://github.com/ebiggers/libdeflate/archive/v1.7.tar.gz'
  source_sha256 'a5e6a0a9ab69f40f0f59332106532ca76918977a974e7004977a9498e3f11350'
  
  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", 'install'
  end
end
