require 'package'

class Zzuf < Package
  description 'zzuf is a transparent application input fuzzer.'
  homepage 'http://caca.zoy.org/wiki/zzuf'
  version '0.15'
  license 'WTFPL'
  compatibility 'all'
  source_url 'https://github.com/samhocevar/zzuf/releases/download/v0.15/zzuf-0.15.tar.bz2'
  source_sha256 '04353d94c68391b3945199f100ab47fc5ff7815db1e92581a600d4175e3a6872'
  
  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.check
    system "make check"
  end
  
  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
