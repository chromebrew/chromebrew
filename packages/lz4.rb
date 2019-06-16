require 'package'

class Lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'http://lz4.github.io/lz4/'
  version '1.9.1'
  source_url 'https://github.com/lz4/lz4/archive/v1.9.1.tar.gz'
  source_sha256 'f8377c89dad5c9f266edc0be9b73595296ecafd5bfa1000de148096c50052dc4'

  def self.build
    system "make", "BUILD_STATIC=no"
  end

  def self.install
    system "make", "BUILD_STATIC=no", "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", "install"
  end
end
