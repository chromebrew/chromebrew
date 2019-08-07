require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'http://kernel.ubuntu.com/~cking/eventstat/'
  version '0.04.06'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/eventstat/eventstat-0.04.06.tar.gz'
  source_sha256 'b5bd29cf02f0c7c1a2d59c7d012e51220f83e2e6ff0829dec4d6cb87a1ec53d6'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make" 
  end

  def self.install
    system "install -Dm755 eventstat #{CREW_DEST_PREFIX}/bin/eventstat"
    system "install -Dm644 eventstat.8 #{CREW_DEST_PREFIX}/man/man8/eventstat.8"
  end
end
