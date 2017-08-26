require 'package'

class Readline7 < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '7.0p3'
  source_url 'ftp://ftp.gnu.org/gnu/readline/readline-7.0.tar.gz'
  source_sha256 '750d437185286f40a369e1e4f4764eda932b9459b5ec9a731628393dd3d32334'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '00f60e0dfaf1758614b7d4cbf99d82676dc04d87dd9b94d15cfdc894054a3379',
     armv7l: '00f60e0dfaf1758614b7d4cbf99d82676dc04d87dd9b94d15cfdc894054a3379',
       i686: '3e722008118112f734c92fd471b8c10d6fff849e458b5bc09f161bdb419b723a',
     x86_64: '0593d6f7a957567728cf074762d7f1063cbb880ec5239e3a99829d92f43dd927',
  })

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
