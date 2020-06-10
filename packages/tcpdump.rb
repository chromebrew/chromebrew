require 'package'

class Tcpdump < Package
  description 'A powerful command-line packet analyzer.'
  homepage 'http://www.tcpdump.org/'
  version '4.9.2'
  compatibility 'all'
  source_url 'http://www.tcpdump.org/release/tcpdump-4.9.2.tar.gz'
  source_sha256 '798b3536a29832ce0cbb07fafb1ce5097c95e308a6f592d14052e1ef1505fe79'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcpdump-4.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcpdump-4.9.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcpdump-4.9.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcpdump-4.9.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fd6105f6f5d0e3d516a2841cef121d6a9e48311cae1bcb3081aed66f7c008aaa',
     armv7l: 'fd6105f6f5d0e3d516a2841cef121d6a9e48311cae1bcb3081aed66f7c008aaa',
       i686: '6baee68c9c358efd4118f2c8555339554e2b75dfd31bd5809db9d9006cd2b620',
     x86_64: 'cbf185dd7cfbbf0d7cf5779fcd661b76c8f9f153f9896bb0a712b196eedc2674',
  })

  depends_on 'libpcap'
  depends_on 'openssl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --with-user=#{USER}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
