require 'package'

class Ffcall < Package
  description 'Foreign function call is a collection of four libraries which can be used to build foreign function call interfaces in embedded interpreters.'
  homepage 'http://www.haible.de/bruno/packages-ffcall-README.html'
  version '1.10-1'
  source_url 'http://www.haible.de/bruno/gnu/ffcall-1.10.tar.gz'
  source_sha256 '6f1b5b8fc84b2c0051637fb1e4e4f8b975f5f98bff8fe053c1992347baa4983d'

  def self.build
    system "./configure --prefix=/usr/local CFLAGS=\" -fPIC\""

    # force to compile in sequential since ffcall Makefile doesn't work in parallel
    system "make", "-j1"
  end

  def self.install
    system "make check"

    # ffcall's `make install` doesn't create intermediate directory, so prepare for it here.
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local"

    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
