require 'package'

class Readline7 < Package

  @patchlevel = 5

  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version "7.0p#{@patchlevel}"
  source_url 'https://ftpmirror.gnu.org/gnu/readline/readline-7.0.tar.gz'
  source_sha256 '750d437185286f40a369e1e4f4764eda932b9459b5ec9a731628393dd3d32334'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "wget --recursive --no-parent https://ftp.gnu.org/gnu/readline/readline-7.0-patches/"
    system "bash -c \"for (( N = 1; N <= #{@patchlevel}; N++ )); do \
              patch -Np0 -i ftp.gnu.org/gnu/readline/readline-7.0-patches/readline70-00\\\${N}; \
            done\""
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-static",
           "--with-curses"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
