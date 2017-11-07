require 'package'

class Newlisp < Package
  description 'newLISP is a Lisp-like, general-purpose scripting language.'
  homepage 'http://www.newlisp.org/'
  version '10.7.1'
  source_url 'https://github.com/kosh04/newlisp/archive/10.7.1.tar.gz'
  source_sha256 '87e3ea4bd2d42118af44f2f881302af32a990164fb47088bcad0be6dc88c5c48'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/newlisp-10.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/newlisp-10.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/newlisp-10.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/newlisp-10.7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e18190cd85ad1bb51af5f64efe67d9262913edd4c2456fd2d27d81d9ad090e39',
     armv7l: 'e18190cd85ad1bb51af5f64efe67d9262913edd4c2456fd2d27d81d9ad090e39',
       i686: 'ef5d7215bff75a090e4babcc0ea1b1fb2719fe98d10ee68f6c402185c279811d',
     x86_64: '6d99a70774a279318953fb48e6c213133426de82175060cb8a03b30b1087662e',
  })

  #depends_on 'readline'
  #depends_on 'libffi'

  def self.build
    # This works but readline and ffi are disabled. When using the
    #  standard ./configure it's looking in the wrong place for ffi.h
    #  and readline isn't linked against libtermcap/ncurses.
    #
    # Looks like the readline issue is the system libreadline vs the
    #  one shipped with bash.
    #
    # Ideally I'll figure out how to get it building properly as follows:
    # system "./configure --prefix=/usr/local --enable-readline --enable-ffi"
    system "./configure-alt --prefix=/usr/local"
    system "make"
    system "make", "check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
