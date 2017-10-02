require 'package'

class Tig < Package
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'http://jonas.nitro.dk/tig/'
  version '2.3.0'
  source_url 'https://github.com/jonas/tig/releases/download/tig-2.3.0/tig-2.3.0.tar.gz'
  source_sha256 '686f0386927904dc6410f0b1a712cb8bd7fff3303f688d7dc43162f4ad16c0ed'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'automake'
  depends_on 'readline'
  depends_on 'ncurses'

  def self.build
    system './autogen.sh'
    system './configure', "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
