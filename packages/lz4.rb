require 'package'

class Lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'https://lz4.github.io/lz4/'
  version '1.9.4'
  license 'BSD-2 and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lz4/lz4/archive/v1.9.4.tar.gz'
  source_sha256 '0b0e3aa07c8c063ddf40b082bdf7e37a1562bda40a0ff5272957f3e987e0e54b'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lz4/1.9.4_armv7l/lz4-1.9.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lz4/1.9.4_armv7l/lz4-1.9.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lz4/1.9.4_i686/lz4-1.9.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lz4/1.9.4_x86_64/lz4-1.9.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8248d98221d940f8a06a0c19562572b5128afe214b9eb83e4c0fc5240706c2e1',
     armv7l: '8248d98221d940f8a06a0c19562572b5128afe214b9eb83e4c0fc5240706c2e1',
       i686: 'ab796d7ebec72971369520ff7a7a87cbdf1c76cd04a2a095c2bf712e72741c5a',
     x86_64: '76a2f4eccf84e78f32bbd2f8e6042f3ed4cda506ca74706fbbc4d60488b54a2a'
  })

  depends_on 'glibc' # R
  no_patchelf

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", 'install'
  end
end
