require 'package'

class Readline7 < Package

  @patchlevel = 5

  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '7.0p5-1'
  source_url 'https://ftpmirror.gnu.org/readline/readline-7.0.tar.gz'
  source_sha256 '750d437185286f40a369e1e4f4764eda932b9459b5ec9a731628393dd3d32334'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9c301f9f269c3ffb8962939d2e6b6d6fd0d62db273440f19e090504f53d2211e',
     armv7l: '9c301f9f269c3ffb8962939d2e6b6d6fd0d62db273440f19e090504f53d2211e',
       i686: '3686aaf9c93d69f3ec4ada1acd625f20c16b2165ffe92df1998a6f124d8e4ff0',
     x86_64: '4e6e13afa0d02688b3431efdbed4f89dc90d8d504adb97eea35fbfbb5ed17688',
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
