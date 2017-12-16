require 'package'

class Fnotifystat < Package
  description 'Fnotifystat is a program that dumps the file system activity in a given period of time.'
  homepage 'http://kernel.ubuntu.com/~cking/fnotifystat/'
  version '0.01.17'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/fnotifystat/fnotifystat-0.01.17.tar.gz'
  source_sha256 'a3ee20e76b39c51f4ac7ee471a50d0c90a04f8588ce4966d22538de56f5e8e59'

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
