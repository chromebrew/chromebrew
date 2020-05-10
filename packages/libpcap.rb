require 'package'

class Libpcap < Package
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'http://www.tcpdump.org/'
  version '1.9.1'
  compatibility 'all'
  source_url 'https://www.tcpdump.org/release/libpcap-1.9.1.tar.gz'
  source_sha256 '635237637c5b619bcceba91900666b64d56ecb7be63f298f601ec786ce087094'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6ed603b0fcfc2262772ab55efaf2ac4aca927131d67e796d9d7b5ebdb4a13646',
     armv7l: '6ed603b0fcfc2262772ab55efaf2ac4aca927131d67e796d9d7b5ebdb4a13646',
       i686: '9eac0cd730345403835a085f5acd9b1648a2610c4cf1f2ae2c3af988d4c28499',
     x86_64: '475bcac8bcd6f24765c68151500470141d5faf85fa89879612d4a0336a43e0ef',
  })

  depends_on 'libnl3'

  def self.build
    system "CFLAGS='-I#{CREW_PREFIX}/include/libnl3' ./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
