require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'http://kernel.ubuntu.com/~cking/eventstat/'
  version '0.04.05'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/eventstat/eventstat-0.04.05.tar.gz'
  source_sha256 '8489b908c742eec3f399976c927f478fbb49af4b64097c72a78783171bf483dd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.05-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.05-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.05-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/eventstat-0.04.05-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '14c39cbfe5e1fc69a658551096db673ceb629cfa04c5b60c1ee8f7410869ed94',
     armv7l: '14c39cbfe5e1fc69a658551096db673ceb629cfa04c5b60c1ee8f7410869ed94',
       i686: 'bc4f42ca0ed30bf873322066ee4d07dc0ddd5e1c171431e79564bedf328ab625',
     x86_64: 'eaaff1c76378147e295fcdb90ccfd74e338c5fa7b242b1999575735802b82122',
  })

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make" 
  end

  def self.install
    system "install -Dm755 eventstat #{CREW_DEST_PREFIX}/bin/eventstat"
    system "install -Dm644 eventstat.8 #{CREW_DEST_PREFIX}/man/man8/eventstat.8"
  end
end
