require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'http://kernel.ubuntu.com/~cking/eventstat/'
  version '0.04.05'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/eventstat/eventstat-0.04.05.tar.gz'
  source_sha256 '8489b908c742eec3f399976c927f478fbb49af4b64097c72a78783171bf483dd'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make" 
  end

  def self.install
    system "install -Dm755 eventstat #{CREW_DEST_PREFIX}/bin/eventstat"
    system "install -Dm644 eventstat.8 #{CREW_DEST_PREFIX}/man/man8/eventstat.8"
  end
end
