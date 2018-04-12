require 'package'

class Pkgconfig < Package
  description 'pkg-config is a helper tool used when compiling applications and libraries.'
  homepage 'https://www.freedesktop.org/wiki/Software/pkg-config/'
  version '0.29.2-0'
  source_url 'http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz'
  source_sha256 '6fc69c01688c9458a57eb9a1664c9aba372ccda420a02bf4429fe610e7e7d591'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '53a0d80b00c745762a25eb9622fdd96f1f2e3a7ff86ca13bec15cdc6c943845c',
     armv7l: '53a0d80b00c745762a25eb9622fdd96f1f2e3a7ff86ca13bec15cdc6c943845c',
       i686: 'bb54749f9ca7f6cf50adc8e52ecf2dc48af3eb1e5bc841e65ecab55142020741',
     x86_64: 'd5084005544be49e828269473c0acd43eb7bb46b7080926c3a9cddd0926c028b',
  })
  
  depends_on 'python27' => :build

  def self.build
    case ARCH
    when "x86_64"
      system "./configure",
             "--with-internal-glib",
             "--with-pc-path=#{CREW_PREFIX}/lib/pkgconfig:#{CREW_PREFIX}/lib64/pkgconfig:#{CREW_PREFIX}/share/pkgconfig",
             "--with-system-include-path=/usr/include:#{CREW_PREFIX}/include",
             "--with-system-library-path=#{CREW_PREFIX}/lib:#{CREW_PREFIX}/lib64",
             "--disable-static",
             "--enable-shared",
             "--disable-host-tool"
    when "i686","armv7l","aarch64"
      system "./configure",
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
