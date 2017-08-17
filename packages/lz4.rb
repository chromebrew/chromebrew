require 'package'

class Lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'http://lz4.github.io/lz4/'
  version '1.7.5-1'
  source_url 'https://github.com/lz4/lz4/archive/v1.7.5.tar.gz'
  source_sha256 '0190cacd63022ccb86f44fa5041dc6c3804407ad61550ca21c382827319e7e7e'

  def self.build
    system "make", "BUILD_STATIC=no"
  end

  def self.install
    system "make", "BUILD_STATIC=no", "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", "install"
  end
end
