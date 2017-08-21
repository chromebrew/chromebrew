require 'package'

class Ctorrent < Package
  description 'CTorrent is a BitTorrent client implemented in C++ to be lightweight and quick.'
  homepage 'http://www.rahul.net/dholmes/ctorrent/'
  version '3.3.2'
  source_url 'http://www.rahul.net/dholmes/ctorrent/ctorrent-dnh3.3.2.tar.gz'
  source_sha256 'c87366c91475931f75b924119580abd06a7b3cb3f00fef47346552cab1e24863'

  depends_on 'openssl' => :build

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
