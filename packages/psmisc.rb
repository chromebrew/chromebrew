require 'package'

class Psmisc < Package
  description 'PSmisc is a set of some small useful utilities that use the proc filesystem.'
  homepage 'http://psmisc.sourceforge.net/'
  version '23.1'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/psmisc/psmisc/psmisc-23.1.tar.xz'
  source_sha256 '2e84d474cf75dfbe3ecdacfb797bbfab71a35c7c2639d1b9f6d5f18b2149ba30'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/psmisc-23.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/psmisc-23.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/psmisc-23.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/psmisc-23.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd757c2abb4b2fe8bc0bd935798cd3520bf211bd0ec260f2b92da049ec4504b17',
     armv7l: 'd757c2abb4b2fe8bc0bd935798cd3520bf211bd0ec260f2b92da049ec4504b17',
       i686: 'dcd49176e24d1b3a193f102594e7385cb73be2ba840a5df2a9c316ce01160341',
     x86_64: '96138e37ff581ce0015c2b592cbcb9aef8b1a86a96109c3e0e686ba7160f2cf5',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make CFLAGS=' -I#{CREW_PREFIX}/include/ncurses'"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
