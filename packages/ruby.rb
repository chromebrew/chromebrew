require 'package'

class Ruby < Package
  version '2.4.0'
  source_url 'http://cache.ruby-lang.org/pub/ruby/ruby-2.4.0.tar.xz'
  source_sha1 '038804bbd0e77508dd2510b729a9f3b325489b2e'
  binary_url ({
    armv7l: 'https://github.com/jam7/chromebrew/releases/download/binaries/ruby-2.4.0-chromeos-armv7l.tar.xz',
    i686:   'https://github.com/jam7/chromebrew/releases/download/binaries/ruby-2.4.0-chromeos-i686.tar.xz',
    x86_64: 'https://github.com/jam7/chromebrew/releases/download/binaries/ruby-2.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    armv7l: '0b8bf1c94b948c26628dbf7d1bf4b2c792296aa2',
    i686:   '745d237e1947e6ab80745303d5afdf5da09399a7',
    x86_64: 'cdd25b0fc4a79c92de2899fca290656999aec4d7',
  })

  depends_on 'gmp'
  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg'
  depends_on 'openssl'

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
