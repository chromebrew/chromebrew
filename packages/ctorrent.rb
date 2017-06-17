require 'package'

class Ctorrent < Package
  description 'CTorrent is a BitTorrent client implemented in C++ to be lightweight and quick.'
  homepage 'http://www.rahul.net/dholmes/ctorrent/'
  version '3.3.2'
  source_url 'http://www.rahul.net/dholmes/ctorrent/ctorrent-dnh3.3.2.tar.gz'
  source_sha1 'd4e221f0292268f80e2430ce9d451dd64cf1ffaa'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
