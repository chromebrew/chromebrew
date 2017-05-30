require 'package'

class Tcpdump < Package
  description 'A powerful command-line packet analyzer.'
  homepage 'http://www.tcpdump.org/'
  version '4.8.1' 
  source_url 'http://www.tcpdump.org/release/tcpdump-4.8.1.tar.gz'
  source_sha1 '364c8a60b637d1b122769fdeae79bcd300d5bd5c'

  depends_on 'libpcap'
  depends_on 'openssl'

  def self.build
    system "./configure --prefix=/usr/local --with-user=chronos"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
