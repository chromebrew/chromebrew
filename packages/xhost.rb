require 'package'

class Xhost < Package
  description 'Server access control program for X'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xhost.1.html'
  version '1.0.7'
  source_url 'https://www.x.org/releases/individual/app/xhost-1.0.7.tar.bz2'
  source_sha256 '93e619ee15471f576cfb30c663e18f5bc70aca577a63d2c2c03f006a7837c29a'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xhost-1.0.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: 'a9efe55993274542bd7cf8f9cc5dd9cd4899396c5218728fb844379b1873334d',
  })

  depends_on 'xorg_lib'

  def self.build
    system "./configure",
           "--enable-ipv6",
           "--enable-tcp-transport",
           "--enable-unix-transport",
           "--prefix=#{CREW_PREFIX}",
           "--enable-local-transport",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

