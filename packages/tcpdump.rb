require 'package'

class Tcpdump < Package
  description 'A powerful command-line packet analyzer.'
  homepage 'http://www.tcpdump.org/'
  version '4.9.1'
  source_url 'http://www.tcpdump.org/release/tcpdump-4.9.1.tar.gz'
  source_sha256 'f9448cf4deb2049acf713655c736342662e652ef40dbe0a8f6f8d5b9ce5bd8f3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcpdump-4.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcpdump-4.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcpdump-4.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcpdump-4.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f3c78ae35bc78252d3f822c75e9ecfcab077bb92dd8982a10a8b70e6b0860141',
     armv7l: 'f3c78ae35bc78252d3f822c75e9ecfcab077bb92dd8982a10a8b70e6b0860141',
       i686: 'a47fa939d82d7ab7a4bff84047a2b7e522455ab2463e1867ecfc1eb44471fcda',
     x86_64: 'a960b5219d852796c63f868f4cd61ea3f36935167b7f59635353cf62ff7d8e4d',
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
