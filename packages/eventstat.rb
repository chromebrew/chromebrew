require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'http://kernel.ubuntu.com/~cking/eventstat/'
  version '0.04.02'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/eventstat/eventstat-0.04.02.tar.gz'
  source_sha256 '1b5a1b18f7331b363ec455db05f27c08e89469de04a01c1392a7bfc149254a72'

  binary_url ({
  })
  binary_sha256 ({
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
