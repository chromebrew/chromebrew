require 'package'

class Pcre < Package
  description 'The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5. http://pcre.org/'
  homepage 'https://ftp.pcre.org/pub/pcre/'
  version '8.41'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.bz2'
  source_sha256 'e62c7eac5ae7c0e7286db61ff82912e1c0b7a0c13706616e94a7dd729321b530'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic", "--enable-utf", "--enable-unicode-properties"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
