require 'package'

class Libjpeg < Package
  version '6.3'
  source_url 'http://www.ijg.org/files/jpegsrc.v6b.tar.gz'
  source_sha1 '7079f0d6c42fad0cfba382cf6ad322add1ace8f9'

  def self.build
    system "./configure --includedir=/usr/local/include --libdir=/usr/local/lib64 CC=\"gcc -m64\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
