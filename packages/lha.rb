require 'package'

class Lha < Package
  description 'LHa for UNIX is a console-based utility that uncompresses and compresses .lha packages.'
  homepage 'https://lha.osdn.jp/'
  version '6f6cbc1'
  compatibility 'all'
  source_url 'https://github.com/jca02266/lha/archive/6f6cbc1.tar.gz'
  source_sha256 'b081f600fd34ab99d5ddf085d0667bc4fa3e44362843935236592ddd999f084f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lha-6f6cbc1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lha-6f6cbc1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lha-6f6cbc1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lha-6f6cbc1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8fa5dd3a57a9da3ffe245f1417f746da3c6d712e4436dcad67a71ec34e1c2e94',
     armv7l: '8fa5dd3a57a9da3ffe245f1417f746da3c6d712e4436dcad67a71ec34e1c2e94',
       i686: '8b5d6ed5ffb6118b36ab7a1ab93519003694fc18b5203ca4f885447aa023965b',
     x86_64: 'e1894e33a4ed0932a493d049007e8d4ac70d94ec5e46247a04d448f23bf32c5d',
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
