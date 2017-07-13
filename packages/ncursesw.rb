require 'package'

class Ncursesw < Package
  description 'ncurses wide-character libraries.'
  homepage 'http://www.gnu.org/software/ncurses/'
  version '6.0-2'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz'
  source_sha256 'f551c24b30ce8bfb6e96d9f59b42fbea30fa3a6123384172f9e7284bcf647260'

  depends_on 'diffutils' => :build

  def self.build
    # Check ncurses doesn't conflict with ncrusesw
    if File.exist? CREW_CONFIG_PATH + "meta/ncurses.filelist"
      if `grep include/ncursesw #{CREW_CONFIG_PATH}meta/ncurses.filelist` != ''
        puts
        puts "PLEASE PERFORM `crew upgrade ncurses` OR `crew remove ncurses` FIRST"
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
    system 'make'
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
  end
end
