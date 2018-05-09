require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'http://kernel.ubuntu.com/~cking/eventstat/'
  version '0.04.03'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/eventstat/eventstat-0.04.03.tar.gz'
  source_sha256 '689d8ef193cc792edc5bf4f66cb6626a1acb78eb79f85b0ee5db744eb78b4378'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.03-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.03-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.03-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.03-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a232969e8df3019c6e3745d1d9c9b4216946fdfb8249e1675e73d41f6072f236',
     armv7l: 'a232969e8df3019c6e3745d1d9c9b4216946fdfb8249e1675e73d41f6072f236',
       i686: '818cfbcce8d75f170854caac30797a63764c800f876ee5718069c13cea2ffb99',
     x86_64: '130e1ce007648c817123d714c20d028987b8f8ee017dc5fe85e61505bacc18c5',
  })

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make" 
  end

  def self.install
    system "install -Dm755 eventstat #{CREW_DEST_PREFIX}/bin/eventstat"
    system "install -Dm644 eventstat.8 #{CREW_DEST_PREFIX}/man/man8/eventstat.8"
  end
end
