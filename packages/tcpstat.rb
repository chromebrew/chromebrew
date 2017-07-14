require 'package'

class Tcpstat < Package
  description 'tcpstat reports certain network interface statistics much like vmstat does for system statistics. tcpstat gets its information by either monitoring a specific interface, or by reading previously saved tcpdump data from a file.'
  homepage 'http://www.frenchfries.net/paul/tcpstat/'
  version '1.5'
  source_url 'https://web.archive.org/web/20160504233625/http://www.frenchfries.net/paul/tcpstat/tcpstat-1.5.tar.gz'
  source_sha256 '46fde9458cc5678264b0c5f2197f84ada9101951197fdeec5f04b0801fcff0ba'

  def self.build
    system "./configure", "--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
