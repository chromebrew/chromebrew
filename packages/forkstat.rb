require 'package'

class Forkstat < Package
  description 'Forkstat is a program that logs process fork(), exec() and exit() activity.'
  homepage 'http://kernel.ubuntu.com/~cking/forkstat/'
  version '0.02.00'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/forkstat/forkstat-0.02.00.tar.gz'
  source_sha256 'af9513d8666441183a8952cf6092b028bc68bcbc091214df137951311615ae1d'

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
