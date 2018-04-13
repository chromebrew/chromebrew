require 'package'

class Libxau < Package
  description 'xau library for libX11'
  homepage 'https://x.org'
  version '1.0.8-1'
  source_url 'https://www.x.org/archive/individual/lib/libXau-1.0.8.tar.gz'
  source_sha256 'c343b4ef66d66a6b3e0e27aa46b37ad5cab0f11a5c565eafb4a1c7590bc71d7b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cddb13bfb9a81cfe5990cf1dd807c78951262bb3c2d5b8d5341da6b491d379e9',
     armv7l: 'cddb13bfb9a81cfe5990cf1dd807c78951262bb3c2d5b8d5341da6b491d379e9',
       i686: 'd902285f810cf1eff4bedcbd344c77997ec39631179c1d3ae2192458d58b44c8',
     x86_64: '199a18b19af06eababe37e01a9308c11726bb6415613cc4ffde38631eaad8269',
  })
  
  depends_on 'xorg_proto'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
