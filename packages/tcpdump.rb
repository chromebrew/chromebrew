require 'package'

class Tcpdump < Package
  description 'A powerful command-line packet analyzer.'
  homepage 'http://www.tcpdump.org/'
  version '4.9.1'
  source_url 'http://www.tcpdump.org/release/tcpdump-4.9.1.tar.gz'
  source_sha256 'f9448cf4deb2049acf713655c736342662e652ef40dbe0a8f6f8d5b9ce5bd8f3'

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
