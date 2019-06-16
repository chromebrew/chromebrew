require 'package'

class Forkstat < Package
  description 'Forkstat is a program that logs process fork(), exec() and exit() activity.'
  homepage 'http://kernel.ubuntu.com/~cking/forkstat/'
  version '0.02.09'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/forkstat/forkstat-0.02.09.tar.xz'
  source_sha256 'bcaf4388bc05731a8f4783270962c702882480ee92eb34fa4c90ab6c7852b0c0'

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
