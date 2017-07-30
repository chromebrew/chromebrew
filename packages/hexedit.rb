require 'package'

class Hexedit < Package
  version '1.2.13'
  description 'Hex Editor for Linux.'
  homepage 'http://rigaux.org/hexedit.html'
  source_url 'http://rigaux.org/hexedit-1.2.13.src.tgz'
  source_sha256 '6a126da30a77f5c0b08038aa7a881d910e3b65d13767fb54c58c983963b88dd7'

  depends_on 'ncurses'

  def self.build
    system "./configure", "--prefix=/usr/local"
    system "make", "CFLAGS=-I/usr/local/include/ncurses"
  end

  def self.install
    system "make", "prefix=#{CREW_DEST_DIR}/usr/local", "install"
  end
end
