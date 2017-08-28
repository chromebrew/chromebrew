require 'package'

class Diffutils < Package
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'http://www.gnu.org/software/diffutils/'
  version '3.6'
  source_url 'https://ftp.gnu.org/gnu/diffutils/diffutils-3.6.tar.xz'
  source_sha256 'd621e8bdd4b573918c8145f7ae61817d1be9deb4c8d2328a65cea8e11d783bd6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/diffutils-3.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/diffutils-3.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/diffutils-3.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/diffutils-3.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '77a30765496cd1c8c81c5494f0d271723fe8594ba32cd97e956548cc113fe4a4',
     armv7l: '77a30765496cd1c8c81c5494f0d271723fe8594ba32cd97e956548cc113fe4a4',
       i686: 'a571f4a127d616f216dce43e72bdb746243b90516a3aa2a3c441c5c7130a5726',
     x86_64: 'd1d6cfc14b969ffb340b99c5fb66791745209ad43198ef1b990ffccb3ac2cb3e',
  })

  depends_on 'libsigsegv'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
