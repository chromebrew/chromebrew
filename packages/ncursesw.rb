require 'package'

class Ncursesw < Package
  description 'ncurses wide-character libraries.'
  homepage 'http://www.gnu.org/software/ncurses/'
  version '6.0-2'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz'
  source_sha1 'acd606135a5124905da770803c05f1f20dd3b21c'

  depends_on "diffutils" => :build

  def self.build
    # Check ncurses doesn't conflict with ncrusesw
    if File.exist? CREW_CONFIG_PATH + "meta/ncurses.filelist"
      if `grep include/ncursesw #{CREW_CONFIG_PATH}meta/ncurses.filelist` != ''
	puts
	puts "PLEASE PERFORMS `crew upgrade ncurses` OR `sudo crew remove ncurses` FIRST"
	puts
	exit 1
      end
    end
    # Build ncursesw
    system './configure',
	    '--prefix=/usr/local',
	    "--libdir=#{CREW_LIB_PREFIX}",
	    '--without-normal',
	    '--with-shared',
	    '--with-cxx-shared',
	    '--without-debug',
	    '--enable-widec'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # remove binary files which are installed by ncurses also
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/clear"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/infocmp"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/tabs"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/tic"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/tput"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/tset"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/toe"

    # strip libraries here since `make install` re-link libraries again
    system "find #{CREW_DEST_DIR}#{CREW_LIB_PREFIX} -name 'lib*.so.*' -print | xargs strip -S"
  end
end
