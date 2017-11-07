require 'package'

class Tcpdump < Package
  description 'A powerful command-line packet analyzer.'
  homepage 'http://www.tcpdump.org/'
  version '4.9.2'
  source_url 'http://www.tcpdump.org/release/tcpdump-4.9.2.tar.gz'
  source_sha256 '798b3536a29832ce0cbb07fafb1ce5097c95e308a6f592d14052e1ef1505fe79'

  binary_url ({
  })
  binary_sha256 ({
  })

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
