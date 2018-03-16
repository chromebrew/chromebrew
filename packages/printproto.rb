require 'package'

class Printproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.0.5-0'
  source_url 'https://www.x.org/archive/individual/proto/printproto-1.0.5.tar.gz'
  source_sha256 'e8b6f405fd865f0ea7a3a2908dfbf06622f57f2f91359ec65d13b955e49843fc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/printproto-1.0.5-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/printproto-1.0.5-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/printproto-1.0.5-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/printproto-1.0.5-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e31b6334ecfa1dd352d0702e61a07cfd7f0e334a0891e414fa3b325308fe1570',
     armv7l: 'e31b6334ecfa1dd352d0702e61a07cfd7f0e334a0891e414fa3b325308fe1570',
       i686: '8382acdb197b250a215ad492497014bc77bfda608ef09401f2251809d17c19f6',
     x86_64: 'f5ee18cf4f16279229252671eb2210d70b1d69d21129f718da8de02cbdc3ccdc',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
