require 'package'

class Readline < Package
  version '6.3p8'
  source_url 'http://ftp.gnu.org/gnu/readline/readline-6.3.tar.gz'
  source_sha1 '017b92dc7fd4e636a2b5c9265a77ccc05798c9e1'

  depends_on 'buildessential' => :build
  depends_on 'patch' => :build
  depends_on 'ncurses'

  def self.build
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches -P readline-6.3-patches"
    # system "for i in readline-6.3-patches/*.sig; do gpg $i; done"
    system "for i in readline-6.3-patches/readline63-???; do patch < $i; done"

    system "CC='gcc' ./configure --disable-static --with-curses"
    system "make"
    system "find . -name 'lib*.so.*' -print | xargs strip -S"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
