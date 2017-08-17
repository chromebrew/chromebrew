require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'http://www.ijg.org/'
  version '9.1-1'
  source_url 'http://www.ijg.org/files/jpegsrc.v9a.tar.gz'
  source_sha256 '3a753ea48d917945dd54a2d97de388aa06ca2eb1066cbfdc6652036349fe05a7'

  def self.build
    system "./configure --includedir=/usr/local/include CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
