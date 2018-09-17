require 'package'

class Libticalcs2 < Package
  description 'Libticalcs2 offers the library used to properly manipulate files on TI calculators.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.1.9'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/libticalcs2-1.1.9.tar.bz2'
  source_sha256 '76780788bc309b647f97513d38dd5f01611c335a72855e0bd10c7bdbf2e38921'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libticables2'

  def self.build
    system 'autoreconf -i'
    system "/usr/bin/env",
      "CC=clang -fuse-ld=lld",
      "CXX=clang++ -fuse-ld=lld",
      "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'sed -i "s,tests,,g" Makefile'
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
