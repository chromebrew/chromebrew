require 'package'

class Libticonv < Package
  description 'Libticonv offers support for performing operations on TI calculators involving charsets.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.1.5'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/libticonv-1.1.5.tar.bz2'
  source_sha256 '316da6a73bf26b266dd23443882abc4c9fe7013edc3a53e5e301d525c2060878'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libticonv-1.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libticonv-1.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libticonv-1.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libticonv-1.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1840b56da2eaa991c01eb6386ba3f1e5176af60d46f2f4bf2c8ae593bd69c1b3',
     armv7l: '1840b56da2eaa991c01eb6386ba3f1e5176af60d46f2f4bf2c8ae593bd69c1b3',
       i686: 'ec397696792faec354b14a30f1fbb46798342bb06f706cca5ec21a1ea4b48407',
     x86_64: '3aee671ec3d182c648c598a5d682a2028db3e12d608edc62f00d1f85bfccb582',
  })

  depends_on 'glib'

  def self.build
    system 'autoreconf -i'
    system "/usr/bin/env",
      "CC=clc -fuse-ld=lld",
      "CXX=clc++ -fuse-ld=lld",
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
