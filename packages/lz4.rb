require 'package'

class Lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'http://lz4.github.io/lz4/'
  version '1.7.5-1'
  source_url 'https://github.com/lz4/lz4/archive/v1.7.5.tar.gz'
  source_sha256 '0190cacd63022ccb86f44fa5041dc6c3804407ad61550ca21c382827319e7e7e'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/lz4-1.7.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/lz4-1.7.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/lz4-1.7.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/lz4-1.7.5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ca0ebdade6a9ed33c8723e5e887573112192b28d611abfd5a1988d7822c4ec74',
     armv7l: 'ca0ebdade6a9ed33c8723e5e887573112192b28d611abfd5a1988d7822c4ec74',
       i686: 'e58ebfa0234dd35c6b6a16570f5f53d889150aa7e2405d1538f53fca60d92007',
     x86_64: '0fb867a1bd3410d3ad0ae5d257e245f00a9ecd6ecbf569dd89039e762c35b9a7',
  })

  def self.build
    system "make", "BUILD_STATIC=no"
  end

  def self.install
    system "make", "BUILD_STATIC=no", "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", "install"
  end
end
