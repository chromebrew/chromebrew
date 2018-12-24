require 'package'

class Readline < Package

  @patchlevel = 8

  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '6.3p8-2'
  source_url 'https://ftpmirror.gnu.org/gnu/readline/readline-6.3.tar.gz'
  source_sha256 '56ba6071b9462f980c5a72ab0023893b65ba6debb4eeb475d7a563dc65cafd43'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '83218261c09120972d87c9710a251e22e1456fc19bd6bf4d0d111e445f9496a7',
     armv7l: '83218261c09120972d87c9710a251e22e1456fc19bd6bf4d0d111e445f9496a7',
       i686: 'cae31632449c2e5530f02d74377d2d61772bf4793fb8aea14e00550f7c9f18da',
     x86_64: '0b6095eabde0211a03f4af71e1497ba06cad8c20a075425d1fae69f0948ce27a',
  })

  def self.build
    system "wget --recursive --no-parent https://ftp.gnu.org/gnu/readline/readline-6.3-patches/"
    system "bash -c \"for (( N = 1; N <= #{@patchlevel}; N++ )); do \
              patch -Np0 -i ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-00\\\${N}; \
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
    system "ln", "-sf", "/#{ARCH_LIB}/libreadline.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libreadline.so.6"
    system "ln", "-sf", "/#{ARCH_LIB}/libreadline.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libreadline.so.6.3"
    system "ln", "-sf", "/#{ARCH_LIB}/libreadline.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libreadline.so"
    system "ln", "-sf", "/#{ARCH_LIB}/libhistory.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libhistory.so.6"
    system "ln", "-sf", "/#{ARCH_LIB}/libhistory.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libhistory.so.6.3"
    system "ln", "-sf", "/#{ARCH_LIB}/libhistory.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libhistory.so"
  end
end
