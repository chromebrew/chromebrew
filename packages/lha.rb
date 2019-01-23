require 'package'

class Lha < Package
  description 'LHa for UNIX is a console-based utility that uncompresses and compresses .lha packages.'
  homepage 'https://lha.osdn.jp/'
  version '6f6cbc1'
  source_url 'https://github.com/jca02266/lha/archive/6f6cbc1.tar.gz'
  source_sha256 'b081f600fd34ab99d5ddf085d0667bc4fa3e44362843935236592ddd999f084f'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.patch
    system "sed -i 's/lha_LDADD.*/& -liconv/' src/Makefile.am"
  end

  def self.build
    system 'autoreconf -sif'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
