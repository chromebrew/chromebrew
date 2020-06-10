require 'package'

class Forkstat < Package
  description 'Forkstat is a program that logs process fork(), exec() and exit() activity.'
  homepage 'http://kernel.ubuntu.com/~cking/forkstat/'
  version '0.02.10'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/forkstat/forkstat-0.02.10.tar.xz'
  source_sha256 'af039bcd9f11ee76721d96c2c65d7e9c8d5df0a3f688bcbe0a5add2dd5dbb6da'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6b971ae55df61fc24af6e86fcc5f52bb61a1f16b6f2a627f70eba6bfbf64f824',
     armv7l: '6b971ae55df61fc24af6e86fcc5f52bb61a1f16b6f2a627f70eba6bfbf64f824',
       i686: 'fb58b945242dea5bd4417b91f8260731cb24b7e3bac3a3a01ef0336a47294506',
     x86_64: '6a80bbd70110150fc340b0085dbf813124d589aa9cd01bfd77995fd45903226e',
  })

  def self.build
    system 'make',
      "BINDIR=#{CREW_PREFIX}/bin",
      "MANDIR=#{CREW_PREFIX}/share/man/man8"
  end

  def self.install
    system 'make',
      "DESTDIR=#{CREW_DEST_DIR}",
      "BINDIR=#{CREW_PREFIX}/bin",
      "MANDIR=#{CREW_PREFIX}/share/man/man8",
      'install'
  end
end
