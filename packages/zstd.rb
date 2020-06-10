require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '1.3.4'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd/archive/v1.3.4.tar.gz'
  source_sha256 '92e41b6e8dd26bbd46248e8aa1d86f1551bc221a796277ae9362954f26d605a9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.3.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.3.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.3.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b07a39cc1d1261a2d7e6259f04e551823f41a1436bd4fe67729b4a569495362c',
     armv7l: 'b07a39cc1d1261a2d7e6259f04e551823f41a1436bd4fe67729b4a569495362c',
       i686: '4647ecc2d3f2a1d528acacdaf2c9ba1ca0afa09e74c04b81215092816058b75e',
     x86_64: 'ad08a04fc5d985a006851254d6f6e20064f75db92081572e1d536969abf849dc',
  })
  
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
