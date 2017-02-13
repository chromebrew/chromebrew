require 'package'

class Ncdu < Package
  version '1.12'
  source_url 'https://dev.yorhel.nl/download/ncdu-1.12.tar.gz'
  source_sha1 'b79b1c44784f334dca74d89a49f49274f14cfeef'

  depends_on "ncurses"

  def self.build
    system "./configure --prefix=/usr/local CPPFLAGS=-I/usr/local/include/ncurses"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
