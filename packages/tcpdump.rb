require 'package'

class Tcpdump < Package
  description 'A powerful command-line packet analyzer.'
  homepage 'http://www.tcpdump.org/'
  version '4.8.1'
  source_url 'http://www.tcpdump.org/release/tcpdump-4.8.1.tar.gz'
  source_sha256 '20e4341ec48fcf72abcae312ea913e6ba6b958617b2f3fb496d51f0ae88d831c'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/tcpdump-4.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/tcpdump-4.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/tcpdump-4.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/tcpdump-4.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '21e0f7d6ec63bb858df19295b2b09bcd56a80dfcc6f6509e27bf2359b6876889',
     armv7l: '21e0f7d6ec63bb858df19295b2b09bcd56a80dfcc6f6509e27bf2359b6876889',
       i686: '90e32c8506a1240468a2f7912816ebcf17f3ad25aac66989267226128819ae24',
     x86_64: 'e519a0710f8b502ba4643492469463ca9591470e8659f3c3782691aea487b44e',
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
