require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.0-2'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz'
  source_sha1 'acd606135a5124905da770803c05f1f20dd3b21c'

  depends_on "diffutils" => :build
  depends_on "ncursesw"

  def self.build
    system './configure',
	    '--prefix=/usr/local',
	    "--libdir=#{CREW_LIB_PREFIX}",
	    '--without-normal',
	    '--with-shared',
	    '--with-cxx-shared',
	    '--without-debug'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # strip binaries
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/clear"
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/infocmp"
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/tabs"
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/tic"
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/tput"
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/tset"
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/toe"

    # strip libraries here since `make install` re-link libraries again
    system "find #{CREW_DEST_DIR}#{CREW_LIB_PREFIX} -name 'lib*.so.*' -print | xargs strip -S"
  end
end
