require 'package'

class Groff < Package
  description 'Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output.'
  homepage 'https://www.gnu.org/software/groff/'
  version '1.22.3-1'
  source_url 'http://ftp.gnu.org/gnu/groff/groff-1.22.3.tar.gz'
  source_sha256 '3a48a9d6c97750bfbd535feeb5be0111db6406ddb7bb79fc680809cda6d828a5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/groff-1.22.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/groff-1.22.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/groff-1.22.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/groff-1.22.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '30ef7c394c4e8c61c5d39b77b421b22e8f656dcf37258fd4dfbc02bc5e484d0f',
     armv7l: '30ef7c394c4e8c61c5d39b77b421b22e8f656dcf37258fd4dfbc02bc5e484d0f',
       i686: 'be9f9f8cd96f3921cc7effe10f1904997101d7931279e05ddaa0555cfb824611',
     x86_64: 'fcd0399b5ec6e0186294a9374571b15f228931e5ca89de8fbbca8702a9c506e1',
  })

  depends_on 'perl'

  def self.build
    system 'INSTALL_PROGRAM=\'${INSTALL} -s\' ./configure'

    # force to compile in sequential since groff Makefile doesn't work in parallel
    system 'make', '-j1'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
