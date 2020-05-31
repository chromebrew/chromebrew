require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.6.9'
  source_url 'https://www.x.org/archive/individual/lib/libX11-1.6.9.tar.bz2'
  source_sha256 '9cc7e8d000d6193fa5af580d50d689380b8287052270f5bb26a5fb6b58b2bed1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aa383fa7778a3ad424129ce6f0df6f793d66ba92e93910b900f460de3902acb6',
     armv7l: 'aa383fa7778a3ad424129ce6f0df6f793d66ba92e93910b900f460de3902acb6',
       i686: '3c44f4318aece50226c295b39ebc4f2f51d16eb4c13207135df5e11fb5005565',
     x86_64: '6bf082987ab469c4ae7e69fe492922f2811cf6601fc1ffbbe9c62220a55265f0',
  })

  depends_on 'xorg_proto'
  depends_on 'libxcb'
  depends_on 'libxtrans'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
