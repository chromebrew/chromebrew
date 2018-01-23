require 'package'

class Tig < Package
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'http://jonas.nitro.dk/tig/'
  version '2.3.0-1'
  source_url 'https://github.com/jonas/tig/releases/download/tig-2.3.0/tig-2.3.0.tar.gz'
  source_sha256 '686f0386927904dc6410f0b1a712cb8bd7fff3303f688d7dc43162f4ad16c0ed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.3.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.3.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.3.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.3.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '73b43ae17f23d942b30a90e4092b315dc5d0b44679d1242f2423c4c7d2cd3561',
     armv7l: '73b43ae17f23d942b30a90e4092b315dc5d0b44679d1242f2423c4c7d2cd3561',
       i686: '3476982a7d2055274c9fd99b0cf87815e0623329b3bfa45d78b2ba44329d61b9',
     x86_64: '59a21ceda7f12ef29719ba7387eeb883220c39ad5b2db660a5b9d4d290554214',
  })

  depends_on 'readline'
  depends_on 'ncurses'

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}"
    system "sed -i 's,\$(QUIET_LINK),,' Makefile"
    system "sed -i 's,\$(QUIET_CC),,' Makefile"
    system "sed -i 's,\$(QUIET_GEN),,g' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
