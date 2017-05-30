require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'http://www.ijg.org/'
  version '9.1-1'
  source_url 'http://www.ijg.org/files/jpegsrc.v9a.tar.gz'
  source_sha1 'd65ed6f88d318f7380a3a5f75d578744e732daca'

  def self.build
    system "./configure --includedir=/usr/local/include CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
