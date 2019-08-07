require 'package'

class Forkstat < Package
  description 'Forkstat is a program that logs process fork(), exec() and exit() activity.'
  homepage 'http://kernel.ubuntu.com/~cking/forkstat/'
  version '0.02.10'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/forkstat/forkstat-0.02.10.tar.xz'
  source_sha256 'af039bcd9f11ee76721d96c2c65d7e9c8d5df0a3f688bcbe0a5add2dd5dbb6da'

  binary_url ({
  })
  binary_sha256 ({
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
