require 'package'

class Ffcall < Package
  version '1.10'
  source_url 'http://www.haible.de/bruno/gnu/ffcall-1.10.tar.gz'
  source_sha1 '6b4fdc7bd38b434bbf3d65508a3d117fc8b349f3'

  def self.build
    system "./configure --prefix=/usr/local --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make check"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
