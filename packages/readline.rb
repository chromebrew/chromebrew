require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '6.3p8'
  source_url 'http://ftp.gnu.org/gnu/readline/readline-6.3.tar.gz'
  source_sha256 '56ba6071b9462f980c5a72ab0023893b65ba6debb4eeb475d7a563dc65cafd43'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7b70ee08258af2bd190b30639306aa4d0b71273cfb702a4ae75003317f19702f',
     armv7l: '7b70ee08258af2bd190b30639306aa4d0b71273cfb702a4ae75003317f19702f',
       i686: '572baf2f2bba47d719714fc97709bc3932abab4bf1a9d838bb47ccd0f1fa4395',
     x86_64: 'f235ee73feba6d2c0bb085042db9462225cda1a18f190a47116417cc6993e716',
  })

  depends_on 'buildessential' => :build
  depends_on 'patch' => :build
  depends_on 'ncurses'

  def self.build
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-001 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-002 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-003 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-004 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-005 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-006 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-007 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-008 -P readline-6.3-patches"
    # system "for i in readline-6.3-patches/*.sig; do gpg $i; done"
    system "for i in readline-6.3-patches/readline63-???; do patch < $i; done"

    system "CC='gcc' ./configure --libdir=#{CREW_LIB_PREFIX} --disable-static --with-curses"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
