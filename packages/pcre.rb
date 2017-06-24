require 'package'

class Pcre < Package
  description 'The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5.'
  homepage 'http://pcre.org/'
  version '8.40'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.bz2'
  source_sha1 '12f338719b8b028a2eecbf9192fcc00a13fc04f6'
  
  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic", "--enable-utf"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
    system "strip -S #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/lib*.so.*"
  end

  def self.check
    system "make", "check"
  end
end
