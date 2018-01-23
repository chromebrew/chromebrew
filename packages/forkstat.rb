require 'package'

class Forkstat < Package
  description 'Forkstat is a program that logs process fork(), exec() and exit() activity.'
  homepage 'http://kernel.ubuntu.com/~cking/forkstat/'
  version '0.02.00'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/forkstat/forkstat-0.02.00.tar.gz'
  source_sha256 'af9513d8666441183a8952cf6092b028bc68bcbc091214df137951311615ae1d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.00-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.00-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.00-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.00-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '82d09e9de49cbbf37a8ed9c19e9953d2339f9a9407ecbd5d212a7e593a08efd1',
     armv7l: '82d09e9de49cbbf37a8ed9c19e9953d2339f9a9407ecbd5d212a7e593a08efd1',
       i686: 'caba996e9f33d6b44d4275957ddd637691010ad358155b07925c6958e555c27e',
     x86_64: '8ccd0104a118c18baaa7772042a0cb34132cde7bfd84be3090792da3d0d5cf53',
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
