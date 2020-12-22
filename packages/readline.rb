require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '8.1'
  compatibility 'all'
  source_url 'https://gnu.askapache.com/readline/readline-8.1.tar.gz'
  source_sha256 'f8ceb4ee131e3232226a17f51b164afc46cd0b9e6cef344be87c65962cb82b02'


  def self.build
    system "./configure #{CREW_OPTIONS} \
    --disable-install-examples \
    --disable-static \
    --with-curses"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
