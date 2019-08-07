require 'package'

class Fnotifystat < Package
  description 'Fnotifystat is a program that dumps the file system activity in a given period of time.'
  homepage 'http://kernel.ubuntu.com/~cking/fnotifystat/'
  version '0.02.02'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/fnotifystat/fnotifystat-0.02.02.tar.gz'
  source_sha256 'a57034f8b8db3f43b28bfd2e15a27b599a5705809c59c3983b36276f6764a691'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "make"
    system "gzip -9 fnotifystat.8"
  end

  def self.install
    system "install -Dm755 fnotifystat #{CREW_DEST_PREFIX}/bin/fnotifystat"
    system "install -Dm644 fnotifystat.8.gz #{CREW_DEST_PREFIX}/share/man/man8/fnotifystat.8.gz"
  end
end
