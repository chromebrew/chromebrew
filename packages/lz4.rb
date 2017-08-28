require 'package'

class Lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'http://lz4.github.io/lz4/'
  version '1.8.0'
  source_url 'https://github.com/lz4/lz4/archive/v1.8.0.tar.gz'
  source_sha256 '2ca482ea7a9bb103603108b5a7510b7592b90158c151ff50a28f1ca8389fccf6'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "make", "BUILD_STATIC=no"
  end

  def self.install
    system "make", "BUILD_STATIC=no", "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", "install"
  end
end
