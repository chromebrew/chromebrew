require 'package'

class Fnotifystat < Package
  description 'Fnotifystat is a program that dumps the file system activity in a given period of time.'
  homepage 'http://kernel.ubuntu.com/~cking/fnotifystat/'
  version '0.01.17'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/fnotifystat/fnotifystat-0.01.17.tar.gz'
  source_sha256 'a3ee20e76b39c51f4ac7ee471a50d0c90a04f8588ce4966d22538de56f5e8e59'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fnotifystat-0.01.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fnotifystat-0.01.17-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fnotifystat-0.01.17-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fnotifystat-0.01.17-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '177c8ac969de43371c96834b49d5bcfc35fb7d3e07ddeb63cc474730605d022d',
     armv7l: '177c8ac969de43371c96834b49d5bcfc35fb7d3e07ddeb63cc474730605d022d',
       i686: '18a7ca4fc7d7792e8182396fcab20c1219f22fe8303738ce4673ae6c2f465eac',
     x86_64: 'eaec7dd57a936028af07522923cfd5b9c893499106751f811be3b70683d2120f',
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
