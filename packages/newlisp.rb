require 'package'

class Newlisp < Package
  description 'newLISP is a Lisp-like, general-purpose scripting language.'
  homepage 'http://www.newlisp.org/'
  version '10.7.1'
  source_url 'https://github.com/kosh04/newlisp/archive/10.7.1.tar.gz'
  source_sha1 '258d88a6c52ecea73da1a7774fa4f53a265da073'

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
