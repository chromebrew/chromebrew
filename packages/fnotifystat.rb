require 'package'

class Fnotifystat < Package
  description 'Fnotifystat is a program that dumps the file system activity in a given period of time.'
  homepage 'http://kernel.ubuntu.com/~cking/fnotifystat/'
  version '0.02.02'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/fnotifystat/fnotifystat-0.02.02.tar.gz'
  source_sha256 'a57034f8b8db3f43b28bfd2e15a27b599a5705809c59c3983b36276f6764a691'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fnotifystat-0.02.02-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fnotifystat-0.02.02-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fnotifystat-0.02.02-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fnotifystat-0.02.02-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8a316ded5cb90ac39118ca8b1741b6dcae7401a761a1bbe97a024a161938f693',
     armv7l: '8a316ded5cb90ac39118ca8b1741b6dcae7401a761a1bbe97a024a161938f693',
       i686: '78a5878a685c18d2f87bdc9d4f31d7023862c4f30a9552a005bd85f393a5f335',
     x86_64: '2303d784fb7d21510324999f1c1f8e0b67891b98be2441ea48bbbcf2938d5f31',
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
