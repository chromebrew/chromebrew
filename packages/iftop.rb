require 'package'

class Iftop < Package
  description 'iftop does for network usage what top(1) does for CPU usage.'
  homepage 'http://www.ex-parrot.com/pdw/iftop/'
  version '0.17'
  source_url 'http://www.ex-parrot.com/pdw/iftop/download/iftop-0.17.tar.gz'
  source_sha256 'd032547c708307159ff5fd0df23ebd3cfa7799c31536fa0aea1820318a8e0eac'

  depends_on 'libpcap'
  depends_on 'ncurses'

  def self.build
    system './configure --prefix=/usr/local CPPFLAGS="-I/usr/local/include/ncurses"'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
