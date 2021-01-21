require 'package'

class Dejagnu < Package
  description 'DejaGnu is a framework for running test suites on GNU tools.'
  homepage 'http://www.gnu.org/s/dejagnu/'
  version '1.6.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/dejagnu/dejagnu-1.6.1.tar.gz'
  source_sha256 'bf5b28bb797e0ace4cfc0766a996339c795d8223bef54158be7887046bc01692'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dejagnu-1.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dejagnu-1.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dejagnu-1.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dejagnu-1.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94e52d8bd744a7addadcc5572f5ca4707661abe30f0f3215d0e992041ef96b78',
     armv7l: '94e52d8bd744a7addadcc5572f5ca4707661abe30f0f3215d0e992041ef96b78',
       i686: '7d6e49ec531dc68955be26dae85aacf390366cc047624538897a72414f3011bf',
     x86_64: 'f3f6810d737976abb4f7e7f6d0a659fc4206d0f8067febb13e2fde63c38467f0',
  })

  depends_on 'expect'
  depends_on 'texinfo'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "makeinfo --html --no-split -o doc/dejagnu.html doc/dejagnu.texi"
    system "makeinfo --plaintext       -o doc/dejagnu.txt  doc/dejagnu.texi"
  end

  def self.check
    system "make check"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    system "install -v -dm755   #{CREW_DEST_PREFIX}/share/doc/dejagnu-1.6.1"
    system "install -v -m644 doc/dejagnu.html #{CREW_DEST_PREFIX}/share/doc/dejagnu-1.6.1"
    system "install -v -m644 doc/dejagnu.txt  #{CREW_DEST_PREFIX}/share/doc/dejagnu-1.6.1"
  end

end
