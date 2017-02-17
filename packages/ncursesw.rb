require 'package'

class Ncursesw < Package
  version '6.0'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz'
  source_sha1 'acd606135a5124905da770803c05f1f20dd3b21c'

  depends_on "diffutils"

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
    system './configure ' \
	    'CFLAGS=" -fPIC" ' \
	    '--without-debug ' \
	    '--prefix=/usr/local ' \
	    '--with-shared ' \
	    '--with-cxx-shared ' \
	    '--enable-widec'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
