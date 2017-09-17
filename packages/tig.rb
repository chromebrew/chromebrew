require 'package'

class Tig < Package
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'http://jonas.nitro.dk/tig/'
  version '2.2.2'
  source_url 'https://github.com/jonas/tig/archive/tig-2.2.2.tar.gz'
  source_sha256 '01a8e3ceb7aab9fd6298eccd6349cb7e813c4fc396d0da41e8c48edf6570c487'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '88d3da94e10d8170c0bdae87447c43ef15c0ef04123e2eaea8a20887f406d76e',
     armv7l: '88d3da94e10d8170c0bdae87447c43ef15c0ef04123e2eaea8a20887f406d76e',
       i686: '42a3bf328d63a6e919e9364144c23c74a6bac8bc7b047e72a3e20ea8b5897730',
     x86_64: 'c711de30d14d3d72a09a155303e5b4231bebd383f1466902895b7a0eca595ad9',
  })

  depends_on 'automake'
  depends_on 'readline'
  depends_on 'ncurses'

  def self.build
    system "./autogen.sh"
    system "./configure", "--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
