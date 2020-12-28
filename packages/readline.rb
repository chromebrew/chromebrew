require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '8.1'
  compatibility 'all'
  source_url 'https://gnu.askapache.com/readline/readline-8.1.tar.gz'
  source_sha256 'f8ceb4ee131e3232226a17f51b164afc46cd0b9e6cef344be87c65962cb82b02'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '4c2e3ab6488be4b58a28975f4e9f2fa7fb8649402cf4268c15c708bce9667f20',
      armv7l: '4c2e3ab6488be4b58a28975f4e9f2fa7fb8649402cf4268c15c708bce9667f20',
        i686: '9033816a26e04eb5c846ecb18f7354b1bbabf9cf5b8710e8843868dfee9d8a80',
      x86_64: 'ddd7cf950d05c8492834b60ff0dbb124f07158c671784eb78118e0fa71691d1b',
  })



  def self.build
    system "./configure #{CREW_OPTIONS} \
    --with-curses"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
