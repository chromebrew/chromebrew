require 'package'

class Pkgconfig < Package
  description 'pkg-config is a helper tool used when compiling applications and libraries.'
  homepage 'https://www.freedesktop.org/wiki/Software/pkg-config/'
  version '0.29.2-0'
  compatibility 'all'
  source_url 'http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz'
  source_sha256 '6fc69c01688c9458a57eb9a1664c9aba372ccda420a02bf4429fe610e7e7d591'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '38f69777e092690dd565ce6d43bfbc6b3906d81d6547c889b8c869bca10c3d40',
     armv7l: '38f69777e092690dd565ce6d43bfbc6b3906d81d6547c889b8c869bca10c3d40',
       i686: '3e4407346894c23be4a9f67bea88815b0086a292ab70fea149c20ff99017103b',
     x86_64: '9ec6d03083164dd778e3cdfc75224c4d307adad2ac93ce1a0077a14e6d6390cc',
  })
  
  depends_on 'python27' => :build

  def self.build
    case ARCH
    when "x86_64"
      system "./configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--with-internal-glib",
             "--with-pc-path=#{CREW_PREFIX}/lib/pkgconfig:#{CREW_PREFIX}/lib64/pkgconfig:#{CREW_PREFIX}/share/pkgconfig",
             "--with-system-include-path=/usr/include:#{CREW_PREFIX}/include",
             "--with-system-library-path=#{CREW_PREFIX}/lib:#{CREW_PREFIX}/lib64",
             "--disable-static",
             "--enable-shared",
             "--disable-host-tool"
    when "i686","armv7l","aarch64"
      system "./configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--with-internal-glib",
             "--with-pc-path=#{CREW_PREFIX}/lib/pkgconfig:#{CREW_PREFIX}/share/pkgconfig",
             "--with-system-include-path=/usr/include:#{CREW_PREFIX}/include",
             "--with-system-library-path=#{CREW_PREFIX}/lib",
             "--disable-static",
             "--enable-shared",
             "--disable-host-tool"
    end
    system "make"

  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
