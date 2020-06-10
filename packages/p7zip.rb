require 'package'

class P7zip < Package
  description 'p7zip is a port of 7za.exe for POSIX systems like Unix (Linux, Solaris, OpenBSD, FreeBSD, Cygwin, AIX, ...), MacOS X and also for BeOS and Amiga.'
  homepage 'http://p7zip.sourceforge.net/'
  version '16.02-1'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/p7zip/p7zip_16.02_src_all.tar.bz2'
  source_sha256 '5eb20ac0e2944f6cb9c2d51dd6c4518941c185347d4089ea89087ffdd6e2341f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/p7zip-16.02-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/p7zip-16.02-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/p7zip-16.02-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/p7zip-16.02-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94509c549bb31a131364b641b482626383a230d78dfb9c584c27108fab5786d7',
     armv7l: '94509c549bb31a131364b641b482626383a230d78dfb9c584c27108fab5786d7',
       i686: 'aa5d21f6d24448ad0f171799dd5981da7dd38289fe7005540b86f67bfd605cf5',
     x86_64: 'bb7f5b85be2cf5f91dc6d4e1d44d1392c3c2be7857e56edca7d101a6f6a0e6fb',
  })

  def self.build
    system "cp", "makefile.linux_any_cpu", "makefile.machine"
    system "make", "all3"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}",
           "DEST_DIR=#{CREW_DEST_DIR}", "install"
  end
end
