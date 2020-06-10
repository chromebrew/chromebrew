require 'package'

class Lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'https://lz4.github.io/lz4/'
  version '1.9.2'
  compatibility 'all'
  source_url 'https://github.com/lz4/lz4/archive/v1.9.2.tar.gz'
  source_sha256 '658ba6191fa44c92280d4aa2c271b0f4fbc0e34d249578dd05e50e76d0e5efcc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.9.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.9.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.9.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '103784c0d0f91d022a0d6487550d87b8cefd0452d168cf53e794b44d458a8142',
     armv7l: '103784c0d0f91d022a0d6487550d87b8cefd0452d168cf53e794b44d458a8142',
       i686: 'b18dd62ffc90a8c5db2f95c9fc8ca130027077f00ed24ff812eec16f0b09979d',
     x86_64: '6042be5675f4a8d7deb51f595bb97fcd4932be5ffcd8ffbc3d2e8c9de03d55ba',
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", 'install'
  end
end
