require 'package'

class Libtasn1 < Package
  description 'Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.'
  homepage 'https://www.gnu.org/software/libtasn1/'
  version '4.12'
  source_url 'https://ftpmirror.gnu.org/libtasn1/libtasn1-4.12.tar.gz'
  source_sha256 '6753da2e621257f33f5b051cc114d417e5206a0818fe0b1ecfd6153f70934753'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '88e880dfcb967d2e267d6a9cb5edd7edc24102e3512b976372a59707aa3f800d',
     armv7l: '88e880dfcb967d2e267d6a9cb5edd7edc24102e3512b976372a59707aa3f800d',
       i686: '480a302070acd99918eb8f38ba2811b352e1ffa34c930906072d6f4986c3cd70',
     x86_64: '0dcf60ecafad42147372010b35f360ec8f364443aaeccb1805f71b8ba568385f',
  })

  # bison, diff, cmp are required at compile-time
  depends_on 'bison' => :build
  depends_on 'diffutils' => :build

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic",
      "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
