require 'package'

class Ffcall < Package
  version '1.10-1'
  source_url 'http://www.haible.de/bruno/gnu/ffcall-1.10.tar.gz'
  source_sha1 '6b4fdc7bd38b434bbf3d65508a3d117fc8b349f3'

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
