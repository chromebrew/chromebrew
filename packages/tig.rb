require 'package'

class Tig < Package
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'https://jonas.github.io/tig/'
  version '2.4.1'
  source_url 'https://github.com/jonas/tig/releases/download/tig-2.4.1/tig-2.4.1.tar.gz'
  source_sha256 'b6b6aa183e571224d0e1fab3ec482542c1a97fa7a85b26352dc31dbafe8558b8'

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
