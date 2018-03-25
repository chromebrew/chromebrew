require 'package'

class Tack < Package
  description 'terminfo action checker'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '1.08'
  source_url 'https://ftpmirror.gnu.org/ncurses/tack-1.08.tar.gz'
  source_sha256 '60f8515eed87176e1f74ac81372645df14dcffbf200d778353e56f640d55b1f2'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
