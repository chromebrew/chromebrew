require 'package'

class Pcre < Package
  description 'The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5.'
  homepage 'http://pcre.org/'
  version '8.40'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.bz2'
  source_sha256 '00e27a29ead4267e3de8111fcaa59b132d0533cdfdbdddf4b0604279acbcf4f4'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic", "--enable-utf"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
