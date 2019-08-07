require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'http://kernel.ubuntu.com/~cking/eventstat/'
  version '0.04.06'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/eventstat/eventstat-0.04.06.tar.gz'
  source_sha256 'b5bd29cf02f0c7c1a2d59c7d012e51220f83e2e6ff0829dec4d6cb87a1ec53d6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.06-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.06-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.06-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.06-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c6019e27bf05402a21cfe420fbb5f4c49c6a8f9c34ab47fee9425279fc5cf9a8',
     armv7l: 'c6019e27bf05402a21cfe420fbb5f4c49c6a8f9c34ab47fee9425279fc5cf9a8',
       i686: 'a06352f14faba8e3293168df46f134094dca45bf972737409003c9e2b1cc5f0b',
     x86_64: 'ccd7916d0f4561b82ac923be2d71056a453edd8998b56eeac4aa84b9aeda83c2',
  })

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make" 
  end

  def self.install
    system "install -Dm755 eventstat #{CREW_DEST_PREFIX}/bin/eventstat"
    system "install -Dm644 eventstat.8 #{CREW_DEST_PREFIX}/share/man/man8/eventstat.8"
  end
end
