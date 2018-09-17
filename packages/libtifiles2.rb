require 'package'

class Libtifiles2 < Package
  description 'Libtifiles2 offers the library used to properly manipulate files on TI calculators.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.1.7'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/libtifiles2-1.1.7.tar.bz2'
  source_sha256 '9ac63b49e97b09b30b37bbc84aeb15fa7967bceb944e56141c5cd5a528acc982'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libticonv'
  depends_on 'libarchive'

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
