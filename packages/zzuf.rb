require 'package'

class Zzuf < Package
  description 'zzuf is a transparent application input fuzzer.'
  homepage 'http://caca.zoy.org/wiki/zzuf'
  version '0.15'
  license 'WTFPL'
  compatibility 'all'
  source_url 'https://github.com/samhocevar/zzuf/releases/download/v0.15/zzuf-0.15.tar.bz2'
  source_sha256 '04353d94c68391b3945199f100ab47fc5ff7815db1e92581a600d4175e3a6872'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'feff06cc3eb02aed4eb9c027bc528580aba6b0ccf9c1bfd189c76a562439ed28',
     armv7l: 'feff06cc3eb02aed4eb9c027bc528580aba6b0ccf9c1bfd189c76a562439ed28',
       i686: 'fc620b537e809bfcd5a7c598ba25c60ab8ce5a8091d2ba0330cbce19ecd466dc',
     x86_64: '013eef3b0e2c088071352d6a29e60c9b1562db09a5371e427a6d9cc387ec1092'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
