require 'package'

class Tig < Package
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'http://jonas.nitro.dk/tig/'
  version '2.3.0-1'
  source_url 'https://github.com/jonas/tig/releases/download/tig-2.3.0/tig-2.3.0.tar.gz'
  source_sha256 '686f0386927904dc6410f0b1a712cb8bd7fff3303f688d7dc43162f4ad16c0ed'

  binary_url ({
  })
  binary_sha256 ({
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
