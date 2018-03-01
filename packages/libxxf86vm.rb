require 'package'

class Libxxf86vm < Package
  description 'X.org the client library for the XFree86-VidMode X extension.'
  homepage 'http://www.x.org'
  version '1.1.4'
  source_url 'https://www.x.org/archive//individual/lib/libXxf86vm-1.1.4.tar.gz'
  source_sha256 '5108553c378a25688dcb57dca383664c36e293d60b1505815f67980ba9318a99'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86vm-1.1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86vm-1.1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86vm-1.1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxxf86vm-1.1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '414cf54c14e966e49268737d45796b5c9422494d74e0fbd685bb80fa4b8e1dfc',
     armv7l: '414cf54c14e966e49268737d45796b5c9422494d74e0fbd685bb80fa4b8e1dfc',
       i686: '2581b7cea2747dc9f82f0b25beb57afdcbdd9378da59e45f7a7e2c75816184e6',
     x86_64: '5288bf141f7688eacd7c622d22adf7e24090685c584f25e2c6e7d29d06b8650e',
  })

  depends_on 'xf86vidmodeproto'
  depends_on 'libxext'
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end