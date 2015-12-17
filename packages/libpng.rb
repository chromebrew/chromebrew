require 'package'

class Libpng < Package
  version '1.6.19'
  source_url 'http://downloads.sourceforge.net/project/libpng/libpng16/1.6.19/libpng-1.6.19.tar.xz'
  source_sha1 '483d72ced11c9258f9d1119105273d9af9ff151c'

  def self.build
      system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
