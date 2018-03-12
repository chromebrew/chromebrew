require 'package'

class Xineramaproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2-0'
  source_url 'https://www.x.org/archive/individual/proto/xineramaproto-1.2.tar.gz'
  source_sha256 'd1298f7e3bea0790bd3c93516b83ff4551b20b544c50fd231d53fc4b5ba93100'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xineramaproto-1.2-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xineramaproto-1.2-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xineramaproto-1.2-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xineramaproto-1.2-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '8a2e27e03102eafb17f682e3f2c13aba090b4ea73b47d85d2444634cf5ed78e3',
     armv7l: '8a2e27e03102eafb17f682e3f2c13aba090b4ea73b47d85d2444634cf5ed78e3',
       i686: '5374cd90d4b5472b356979056b2fd9f668d9c049a7b9217e817c6821648487be',
     x86_64: '3bc1cd4a026e46928d0466fb6a795bb37e473bedef34db965117346b1b54e97c',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
