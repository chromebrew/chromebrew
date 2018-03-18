require 'package'

class Libxau < Package
  description 'xau library for libX11'
  homepage 'https://x.org'
  version '1.0.8-0'
  source_url 'https://www.x.org/archive/individual/lib/libXau-1.0.8.tar.gz'
  source_sha256 'c343b4ef66d66a6b3e0e27aa46b37ad5cab0f11a5c565eafb4a1c7590bc71d7b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2a74fc3599a7b3fffb1bf7162f21180bc605577c0b321ccf5c2c80fb9ccd8ee6',
     armv7l: '2a74fc3599a7b3fffb1bf7162f21180bc605577c0b321ccf5c2c80fb9ccd8ee6',
       i686: 'ffae80264a076163bd87e1d58f84987f10889eee72899b35ab0f7645457120f7',
     x86_64: 'ddd472d59b42ef0ec6b8103d4e1b3293e31a6c2a81d900f7292fe052c151ac4c',
  })
  
  depends_on 'xproto'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
