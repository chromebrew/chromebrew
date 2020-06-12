require 'package'

class Pcre < Package
  description 'The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5.'
  homepage 'http://pcre.org/'
  version '8.44'
  compatibility 'all'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.bz2'
  source_sha256 '19108658b23b3ec5058edc9f66ac545ea19f9537234be1ec62b714c84399366d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b4c172b57311480be50e1f683d1df5319bd92aac6c154d0c940d35d95fc23688',
     armv7l: 'b4c172b57311480be50e1f683d1df5319bd92aac6c154d0c940d35d95fc23688',
       i686: '16d71a0624f07bb7cc341cbcec798a0838bbac822df307c6d4ff20a2061a8f5e',
     x86_64: '99901d63534b07b3cfde714bfbc10b1eb19eef49fb68a8d9e498cac58a523f01',
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic", "--enable-utf"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
