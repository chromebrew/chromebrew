require 'package'

class Lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'https://lz4.org/'
  version '1.10.0'
  license 'BSD-2 and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lz4/lz4.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '441620cf23567ee829c2c61e44c96f3230aa5df9780ef46708a16da3c1d13984',
     armv7l: '441620cf23567ee829c2c61e44c96f3230aa5df9780ef46708a16da3c1d13984',
       i686: 'c1ee1b29762fe352bb1fa588b5ae8ddc4589b45479bebe0723449258fabac7b2',
     x86_64: '6e07a8d095f778015b2e30681f3d17e37bbd33b13c52f1ae2468e3f90a85cffd'
  })

  depends_on 'glibc' # R
  no_zstd

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", 'install'
  end
end
