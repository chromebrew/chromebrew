require 'package'

class Libpcap < Package
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'http://www.tcpdump.org/'
  version '1.8.1-0'
  source_url 'https://www.tcpdump.org/release/libpcap-1.8.1.tar.gz'
  source_sha256 '673dbc69fdc3f5a86fb5759ab19899039a8e5e6c631749e48dcd9c6f0c83541e'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.8.1-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.8.1-0-chromeos-x86_64.tar.xz',
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.8.1-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpcap-1.8.1-0-chromeos-armv7l.tar.xz',
  })
  binary_sha256 ({
       i686: '6b0bdf1e1e244d3eac8ade1a2ba5f4442af97567a785638b6fc7619a06381465',
     x86_64: 'f6b91e914ff739c6b17160da29566af9746b4c38ad7ff24394b43594d62eb8b6',
    aarch64: 'not',
     armv7l: 'not',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
