require 'package'

class Libticalcs2 < Package
  description 'Libticalcs2 offers the library used to communicate with TI calculators. It implements the TI protocol for each type of calculator, independently of the link cable used to establish the link.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.1.9'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/libticalcs2-1.1.9.tar.bz2'
  source_sha256 '76780788bc309b647f97513d38dd5f01611c335a72855e0bd10c7bdbf2e38921'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libticalcs2/1.1.9_armv7l/libticalcs2-1.1.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libticalcs2/1.1.9_armv7l/libticalcs2-1.1.9-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libticalcs2/1.1.9_i686/libticalcs2-1.1.9-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libticalcs2/1.1.9_x86_64/libticalcs2-1.1.9-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c521ad206de70263a713e42c1526830c962fe57ebb38bbd7be1e96330f52c9be',
     armv7l: 'c521ad206de70263a713e42c1526830c962fe57ebb38bbd7be1e96330f52c9be',
       i686: '3ffb6b842192200bb3e3e86639ebb6998ab739bfd1ae50dc81d1652b3197f3ae',
     x86_64: '5adc51ec8a06836e6d9012fea6edf80c896cacf3dd6f8a759b1fac7bf4987626'
  })

  depends_on 'libticables2'

  def self.build
    system 'autoreconf -i'
    system '/usr/bin/env',
           'CC=clc -fuse-ld=lld',
           'CXX=clc++ -fuse-ld=lld',
           './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'sed -i "s,tests,,g" Makefile'
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
