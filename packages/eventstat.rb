require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'http://kernel.ubuntu.com/~cking/eventstat/'
  version '0.04.07'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/eventstat/eventstat-0.04.07.tar.gz'
  source_sha256 '492f9ff8b64f1e2d4d4d67607331b87e4bcf95a4acff60d674ff2a391fa9103d'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make" 
  end

  def self.install
    system "install -Dm755 eventstat #{CREW_DEST_PREFIX}/bin/eventstat"
    system "install -Dm644 eventstat.8 #{CREW_DEST_PREFIX}/share/man/man8/eventstat.8"
  end
end
