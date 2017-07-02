require 'package'

class Tcpdump < Package
  description 'A powerful command-line packet analyzer.'
  homepage 'http://www.tcpdump.org/'
  version '4.8.1'
  source_url 'http://www.tcpdump.org/release/tcpdump-4.8.1.tar.gz'
  source_sha256 '20e4341ec48fcf72abcae312ea913e6ba6b958617b2f3fb496d51f0ae88d831c'

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
