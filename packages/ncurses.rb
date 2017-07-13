require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.0-2'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz'
  source_sha256 'f551c24b30ce8bfb6e96d9f59b42fbea30fa3a6123384172f9e7284bcf647260'

  depends_on 'diffutils' => :build
  depends_on 'ncursesw'

  def self.build
    system './configure',
           '--prefix=/usr/local',
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-normal',
           '--with-shared',
           '--with-cxx-shared',
           '--without-debug'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
