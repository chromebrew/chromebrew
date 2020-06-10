require 'package'

class Xauth < Package
  description 'X authority file utility'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xauth.1.html'
  version '1.0.10'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/xauth-1.0.10.tar.bz2'
  source_sha256 '5afe42ce3cdf4f60520d1658d2b17face45c74050f39af45dccdc95e73fafc4d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xauth-1.0.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xauth-1.0.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xauth-1.0.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xauth-1.0.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a246881cf30bade98de08a011f285ea48df3f0e6a6ba0f25d354b46867f45d2e',
     armv7l: 'a246881cf30bade98de08a011f285ea48df3f0e6a6ba0f25d354b46867f45d2e',
       i686: '89f58dee1108c4cf687e9936c741313d1c2eae5aee0bf73163c12a0bc1c32037',
     x86_64: '6a8217ce647c238127d64380e7dc64b5fc0b0763b9ebe8165b40204ef815aff9',
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
