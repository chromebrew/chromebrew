require 'package'

class Readline7 < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '7.0p3'
  source_url 'ftp://ftp.gnu.org/gnu/readline/readline-7.0.tar.gz'
  source_sha1 'd9095fa14a812495052357e1d678b3f2ac635463'

  depends_on 'buildessential' => :build
  depends_on 'patch' => :build
  depends_on 'ncurses'

  def self.build
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-7.0-patches/readline70-001 -P readline-7.0-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-7.0-patches/readline70-002 -P readline-7.0-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-7.0-patches/readline70-003 -P readline-7.0-patches"
    # system "for i in readline-7.0-patches/*.sig; do gpg $i; done"
    system "for i in readline-7.0-patches/readline70-???; do patch < $i; done"

    system "CC='gcc' ./configure --libdir=#{CREW_LIB_PREFIX} --disable-static --with-curses"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
