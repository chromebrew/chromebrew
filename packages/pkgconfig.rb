require 'package'

class Pkgconfig < Package
  description 'pkg-config is a helper tool used when compiling applications and libraries.'
  homepage 'https://www.freedesktop.org/wiki/Software/pkg-config/'
  version '0.29.2-1'
  compatibility 'all'
  source_url 'http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz'
  source_sha256 '6fc69c01688c9458a57eb9a1664c9aba372ccda420a02bf4429fe610e7e7d591'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pkgconfig-0.29.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '88909e28a93e6b1baf864d8ba5b2d3eb28edb9bbc8455211c0d26993562e5895',
     armv7l: '88909e28a93e6b1baf864d8ba5b2d3eb28edb9bbc8455211c0d26993562e5895',
       i686: 'a225901ea0c0236f77f308814acfdfd262a649efd1bee95f21fc5b16fa198f69',
     x86_64: 'e86ed00a42e902ce4364c04d01f8bb94da0e31d740025f978ddb024a06f52ec8',
  })

  def self.build
    case ARCH
    when 'x86_64'
      system './configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             '--with-internal-glib',
             "--with-pc-path=#{CREW_PREFIX}/lib/pkgconfig:#{CREW_PREFIX}/lib64/pkgconfig:#{CREW_PREFIX}/share/pkgconfig",
             "--with-system-include-path=/usr/include:#{CREW_PREFIX}/include",
             "--with-system-library-path=#{CREW_PREFIX}/lib:#{CREW_PREFIX}/lib64",
             '--disable-static',
             '--enable-shared',
             '--disable-host-tool',
             '--with-libiconv=gnu'
    when 'i686','armv7l','aarch64'
      system './configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             '--with-internal-glib',
             "--with-pc-path=#{CREW_PREFIX}/lib/pkgconfig:#{CREW_PREFIX}/share/pkgconfig",
             "--with-system-include-path=/usr/include:#{CREW_PREFIX}/include",
             "--with-system-library-path=#{CREW_PREFIX}/lib",
             '--disable-static',
             '--enable-shared',
             '--disable-host-tool',
             '--with-libiconv=gnu'
    end
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
