require 'package'

class Newlisp < Package
  description 'newLISP is a Lisp-like, general-purpose scripting language.'
  homepage 'http://www.newlisp.org/'
  version '10.7.5'
  source_url 'https://github.com/kosh04/newlisp/archive/10.7.5.tar.gz'
  source_sha256 'bc3272600510fe78d32a85b23e0793c16f9f9ee05605d28ca537bdc322c25dc2'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    # This works but readline and ffi are disabled. When using the
    #  standard ./configure it's looking in the wrong place for ffi.h
    #  and readline isn't linked against libtermcap/ncurses.
    #
    # Looks like the readline issue is the system libreadline vs the
    #  one shipped with bash.
    #
    # Ideally I'll figure out how to get it building properly as follows:
    # system "./configure --prefix=#{CREW_PREFIX} --enable-readline --enable-ffi"
    system "./configure-alt --prefix=#{CREW_PREFIX} --enable-readline"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
