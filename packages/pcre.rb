require 'package'

class Pcre < Package
  description 'The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5.'
  homepage 'http://pcre.org/'
  version '8.41'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.bz2'
  source_sha256 'e62c7eac5ae7c0e7286db61ff82912e1c0b7a0c13706616e94a7dd729321b530'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.41-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.41-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.41-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.41-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b00eb9665606795130adfb074d1566273dd22cf69c9adc0bb89e6cedbfacc383',
     armv7l: 'b00eb9665606795130adfb074d1566273dd22cf69c9adc0bb89e6cedbfacc383',
       i686: '1f44785a94ddff3321ea0fb07fc9844b51af95ee2ad66dcf8293ff36c361c001',
     x86_64: 'be8fb02a9f4e3d6ad1ffa09a45ee7a22042b544f26a25a079e800fb44141c311',
  })

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
