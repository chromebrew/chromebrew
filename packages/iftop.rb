require 'package'

class Iftop < Package
  description 'iftop does for network usage what top(1) does for CPU usage.'
  homepage 'http://www.ex-parrot.com/pdw/iftop/'
  version '0.17'
  source_url 'http://www.ex-parrot.com/pdw/iftop/download/iftop-0.17.tar.gz'
  source_sha1 '75ce6afc8c0bf851278b0a15e66f523af90cfda9'

  depends_on "libpcap"
  depends_on "ncurses"

  def self.build
    system './configure --prefix=/usr/local CPPFLAGS="-I/usr/local/include/ncurses"'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
