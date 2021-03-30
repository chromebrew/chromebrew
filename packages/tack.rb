require 'package'

class Tack < Package
  description 'terminfo action checker'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '1.08-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/ncurses/tack-1.08.tar.gz'
  source_sha256 '60f8515eed87176e1f74ac81372645df14dcffbf200d778353e56f640d55b1f2'

  depends_on 'ncursesw'

  def self.build
    system "env CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw
            ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
