require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.6.5-1'
  source_url 'https://www.x.org/archive/individual/lib/libX11-1.6.5.tar.gz'
  source_sha256 '3abce972ba62620611fab5b404dafb852da3da54e7c287831c30863011d28fb3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.6.5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ff6bc290a58bee7558e7a02e587e7820b6b376d8c33254eac18e63e157c3365b',
     armv7l: 'ff6bc290a58bee7558e7a02e587e7820b6b376d8c33254eac18e63e157c3365b',
       i686: '0c90a7c81ef29662eab897399bd3fb7f49b7d933e2a97abe8a762e21b3eaa5c4',
     x86_64: '566173764c75b30509d33f16efb13d59244a79274b5af833b17a2e1483e26e97',
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
