require 'package'

class Libxt < Package
  description 'X.org X Toolkit Library'
  homepage 'http://www.x.org'
  version '1.1.5-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXt-1.1.5.tar.gz'
  source_sha256 'b59bee38a9935565fa49dc1bfe84cb30173e2e07e1dcdf801430d4b54eb0caa3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxt-1.1.5-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxt-1.1.5-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxt-1.1.5-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxt-1.1.5-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '168593f2dd1628c1816c4504beec2fc997932b28b1fc0e2ddb9043d1400f5523',
     armv7l: '168593f2dd1628c1816c4504beec2fc997932b28b1fc0e2ddb9043d1400f5523',
       i686: '70220d5f6b186bf700907b8b2a92665608f24944dfab22cc9b077a3dd6b18437',
     x86_64: 'ccc5cd728842864ab67d48a85420ba8eb05c19d3a1beb9a5e6ac473ed7a5c9e0',
  })

  depends_on 'libsm'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
