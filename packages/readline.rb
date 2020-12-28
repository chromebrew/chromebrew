equire 'package'

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
     aarch64: '3df33883be2751b151e39c3e17905104002b078fd4e53f11048649c8a34a796f',
      armv7l: '3df33883be2751b151e39c3e17905104002b078fd4e53f11048649c8a34a796f',
        i686: '15526e871c958dff346de263d40775be55b00a248599dab227e3ebab39e0ac1f',
      x86_64: 'bb4452115aca711846392413c50093f813ce68b112780dc7807446f446ab49a4',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
    --disable-install-examples \
    --with-curses"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
