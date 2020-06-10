require 'package'

class Libtifiles2 < Package
  description 'Libtifiles2 offers the library used to properly manipulate files on TI calculators.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.1.7'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/libtifiles2-1.1.7.tar.bz2'
  source_sha256 '9ac63b49e97b09b30b37bbc84aeb15fa7967bceb944e56141c5cd5a528acc982'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtifiles2-1.1.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtifiles2-1.1.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtifiles2-1.1.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtifiles2-1.1.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '14992232b656a28db289b793755ccb263f878ea77e61b85d05357760ebd57fb4',
     armv7l: '14992232b656a28db289b793755ccb263f878ea77e61b85d05357760ebd57fb4',
       i686: '705cff6ef8a9298171a0c70551958c7b1a414f66bf389917b9f75e590503d8b2',
     x86_64: '8498fc7362b92361679935b0968968c1634c5cdc1b2e86cb40a4672882b65d29',
  })

  depends_on 'libticonv'
  depends_on 'libarchive'

  def self.build
    system 'autoreconf -i'
    system "/usr/bin/env",
      "CC=clc -fuse-ld=lld",
      "CXX=clc++ -fuse-ld=lld",
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
