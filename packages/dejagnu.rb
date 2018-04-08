require 'package'

class Dejagnu < Package
  description 'DejaGnu is a framework for running test suites on GNU tools.'
  homepage 'http://www.gnu.org/s/dejagnu/'
  version '1.6.1'
  source_url 'https://ftpmirror.gnu.org/dejagnu/dejagnu-1.6.1.tar.gz'
  source_sha256 'bf5b28bb797e0ace4cfc0766a996339c795d8223bef54158be7887046bc01692'

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
