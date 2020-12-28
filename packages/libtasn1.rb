require 'package'

class Libtasn1 < Package
  description 'Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.'
  homepage 'https://www.gnu.org/software/libtasn1/'
  version '4.16'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/libtasn1/libtasn1-4.16.0.tar.gz'
  source_sha256 '0e0fb0903839117cb6e3b56e68222771bebf22ad7fc2295a0ed7d576e8d4329d'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.16-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.16-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.16-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '18ae0df459ba32ee41fc2efbfbe2934b6a7f44d2cdfda7da417503cb604ff040',
      armv7l: '18ae0df459ba32ee41fc2efbfbe2934b6a7f44d2cdfda7da417503cb604ff040',
        i686: 'a3090be3dcf8aba5107339f405af889ed1e2b67c0728ff53086ed879e5172d9b',
      x86_64: 'd6c37f27c28eed8720445a9dba40780230f7a3b824bf0787e67739714a2bf34a',
  })

  # bison, diff, cmp are required at compile-time
  depends_on 'bison' => :build
  depends_on 'diffutils' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --enable-shared \
      --with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
