require 'package'

class Jbigkit < Package
  description 'JBIG-KIT is a software implementation of the JBIG1 data compression standard'
  homepage 'https://www.cl.cam.ac.uk/~mgk25/jbigkit/'
  version '2.1'
  compatibility 'all'
  source_url 'https://www.cl.cam.ac.uk/~mgk25/jbigkit/download/jbigkit-2.1.tar.gz'
  source_sha256 'de7106b6bfaf495d6865c7dd7ac6ca1381bd12e0d81405ea81e7f2167263d932'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jbigkit-2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jbigkit-2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jbigkit-2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jbigkit-2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '04f05a1e9d64fd440828b26dbab92e332e14cf8877f89dd3a3184ccb394f28ae',
     armv7l: '04f05a1e9d64fd440828b26dbab92e332e14cf8877f89dd3a3184ccb394f28ae',
       i686: '4f5af8e7dcf0d1bb3901be4454bf6fcd1808ce1aac9eeeed339664836328d48a',
     x86_64: 'e9c62cc25c29df8254d6e48e1ac31d4ae801e55f0f7edef4753daa80fbfdeee8',
  })

  def self.patch
    system "sed -i 's,-Wno-unused-result,-Wno-unused-result -fPIC,' Makefile"
  end

  def self.build
    system 'make all'
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' pbmtools/jbgfuzz.pl"
  end

  def self.check
    system 'make', 'test'
  end

  def self.install
    system "install -Dm644 pbmtools/jbgtopbm.1 #{CREW_DEST_PREFIX}/share/man/man1/jbgtopbm.1"
    system "install -Dm644 pbmtools/pbmtojbg.1 #{CREW_DEST_PREFIX}/share/man/man1/pbmtojbg.1"
    system "install -Dm644 pbmtools/pbm.5 #{CREW_DEST_PREFIX}/share/man/man5/pbm.5"
    system "install -Dm644 pbmtools/pgm.5 #{CREW_DEST_PREFIX}/share/man/man5/pgm.5"
    system "install -Dm644 libjbig/jbig.h #{CREW_DEST_PREFIX}/include/jbig.h"
    system "install -Dm644 libjbig/jbig85.h #{CREW_DEST_PREFIX}/include/jbig85.h"
    system "install -Dm644 libjbig/jbig_ar.h #{CREW_DEST_PREFIX}/include/jbig_ar.h"
    system "install -Dm755 pbmtools/jbgfuzz.pl #{CREW_DEST_PREFIX}/bin/jbgfuzz.pl"
    system "install -Dm755 pbmtools/jbgtopbm #{CREW_DEST_PREFIX}/bin/jbgtopbm"
    system "install -Dm755 pbmtools/jbgtopbm85 #{CREW_DEST_PREFIX}/bin/jbgtopbm85"
    system "install -Dm755 pbmtools/pbmtojbg #{CREW_DEST_PREFIX}/bin/pbmtojbg"
    system "install -Dm755 pbmtools/pbmtojbg85 #{CREW_DEST_PREFIX}/bin/pbmtojbg85"
    system "install -Dm755 libjbig/tstcodec #{CREW_DEST_PREFIX}/bin/tstcodec"
    system "install -Dm755 libjbig/tstcodec85 #{CREW_DEST_PREFIX}/bin/tstcodec85"
    system "install -Dm644 libjbig/libjbig.a #{CREW_DEST_LIB_PREFIX}/libjbig.a"
    system "install -Dm644 libjbig/libjbig85.a #{CREW_DEST_LIB_PREFIX}/libjbig85.a"
  end
end
