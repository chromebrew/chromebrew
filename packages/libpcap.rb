require 'package'

class Libpcap < Package
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'http://www.tcpdump.org/'
  version '1.9.1'
  source_url 'https://www.tcpdump.org/release/libpcap-1.9.1.tar.gz'
  source_sha256 '635237637c5b619bcceba91900666b64d56ecb7be63f298f601ec786ce087094'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
