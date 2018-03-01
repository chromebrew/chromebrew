require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'http://kernel.ubuntu.com/~cking/eventstat/'
  version '0.04.02'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/eventstat/eventstat-0.04.02.tar.gz'
  source_sha256 '1b5a1b18f7331b363ec455db05f27c08e89469de04a01c1392a7bfc149254a72'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.02-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.02-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.02-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.02-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '43081e40495cd7dbd791620a54d845bd22782e850e4a9a5b1ddf32262be2f6e0',
     armv7l: '43081e40495cd7dbd791620a54d845bd22782e850e4a9a5b1ddf32262be2f6e0',
       i686: '7005bff92814bfe7045dccaad9b6c118fcb727ecf7be9cafd774e68691539fdc',
     x86_64: '83d141d3524cd2ab1d51b0bff0980ad4b288b811bb78d0c1224779030642d662',
  })

  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make" 
  end

  def self.install
    system "install -Dm755 eventstat #{CREW_DEST_PREFIX}/bin/eventstat"
    system "install -Dm644 eventstat.8 #{CREW_DEST_PREFIX}/man/man8/eventstat.8"
  end
end
