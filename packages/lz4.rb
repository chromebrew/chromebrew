require 'package'

class Lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'https://lz4.github.io/lz4/'
  version '1.9.2'
  source_url 'https://github.com/lz4/lz4/archive/v1.9.2.tar.gz'
  source_sha256 '658ba6191fa44c92280d4aa2c271b0f4fbc0e34d249578dd05e50e76d0e5efcc'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make', 'BUILD_STATIC=no'
  end

  def self.install
    system 'make', 'BUILD_STATIC=no', "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", 'install'
  end
end
