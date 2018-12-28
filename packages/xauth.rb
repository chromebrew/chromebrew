require 'package'

class Xauth < Package
  description 'X authority file utility'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xauth.1.html'
  version '1.0.10'
  source_url 'https://www.x.org/releases/individual/app/xauth-1.0.10.tar.bz2'
  source_sha256 '5afe42ce3cdf4f60520d1658d2b17face45c74050f39af45dccdc95e73fafc4d'

  binary_url ({
  })
  binary_sha256 ({
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
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
