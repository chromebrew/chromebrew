require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.0-1'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz'
  source_sha1 'acd606135a5124905da770803c05f1f20dd3b21c'

  depends_on "diffutils"
  depends_on "ncursesw"

  def self.build
    system './configure ' \
	    'CFLAGS=" -fPIC" ' \
	    '--without-debug ' \
	    '--prefix=/usr/local ' \
	    '--with-shared ' \
	    '--with-cxx-shared '
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.ln_s '/usr/local/include/ncursesw', '/usr/local/include/ncurses'
  end
end
