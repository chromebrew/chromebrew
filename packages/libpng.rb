require 'package'

class Libpng < Package
  version '1.5.22'
  source_url 'http://www.mirrorservice.org/sites/downloads.sourceforge.net/l/li/libpng/libpng15/1.5.22/libpng-1.5.22.tar.gz'
  source_sha1 'e912df0826dd6fb74f579ba60bf05c99807548ac'

  def self.build
      system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
