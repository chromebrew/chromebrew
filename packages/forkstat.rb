require 'package'

class Forkstat < Package
  description 'Forkstat is a program that logs process fork(), exec() and exit() activity.'
  homepage 'http://kernel.ubuntu.com/~cking/forkstat/'
  version '0.02.09'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/forkstat/forkstat-0.02.09.tar.xz'
  source_sha256 'bcaf4388bc05731a8f4783270962c702882480ee92eb34fa4c90ab6c7852b0c0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.09-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.09-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.09-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/forkstat-0.02.09-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '28e501d8851a8b9a9659fd510f6f63ef15743dc0646f2e2b66aed0aed1fcf323',
     armv7l: '28e501d8851a8b9a9659fd510f6f63ef15743dc0646f2e2b66aed0aed1fcf323',
       i686: '9658596efb95130c0e9410beb9236324f65aa000b5bdc42fe9646a18211b64b1',
     x86_64: '81238cb4af354995e19faeeb4f6c709d086dfa3e0dcbe11594b5cf58b66d5921',
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
