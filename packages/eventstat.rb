require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'http://kernel.ubuntu.com/~cking/eventstat/'
  version '0.04.07'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/eventstat/eventstat-0.04.07.tar.gz'
  source_sha256 '492f9ff8b64f1e2d4d4d67607331b87e4bcf95a4acff60d674ff2a391fa9103d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.07-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.07-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.07-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.07-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '638fb6d23929c8d570032bf798d39533f96d77b694b58e99e4cf5d55e1ae9a10',
     armv7l: '638fb6d23929c8d570032bf798d39533f96d77b694b58e99e4cf5d55e1ae9a10',
       i686: '95b38b940095606fe2e2d518fe0e59b3fe9bab251ef278e809204d9a15b30940',
     x86_64: 'a4e8ab12fcab23cf01fb11c6122f46935778c54028da5d8a0a43df9a385cab74',
  })

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make" 
  end

  def self.install
    system "install -Dm755 eventstat #{CREW_DEST_PREFIX}/bin/eventstat"
    system "install -Dm644 eventstat.8 #{CREW_DEST_PREFIX}/share/man/man8/eventstat.8"
  end
end
