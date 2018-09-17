require 'package'

class Libticonv < Package
  description 'Libticonv offers support for performing operations on TI calculators involving charsets.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.1.5'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/libticonv-1.1.5.tar.bz2'
  source_sha256 '316da6a73bf26b266dd23443882abc4c9fe7013edc3a53e5e301d525c2060878'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'

  def self.build
    system 'autoreconf -i'
    system "/usr/bin/env",
      "CC=clang -fuse-ld=lld",
      "CXX=clang++ -fuse-ld=lld",
      "./configure",
      "--enable-iconv",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'sed -i "s,tests,,g" Makefile'
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
