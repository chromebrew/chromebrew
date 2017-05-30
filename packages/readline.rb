require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '6.3'
  source_url 'http://ftp.gnu.org/gnu/readline/readline-6.3.tar.gz'
  source_sha1 '017b92dc7fd4e636a2b5c9265a77ccc05798c9e1'

  depends_on 'buildessential'

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
