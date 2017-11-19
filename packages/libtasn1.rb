require 'package'

class Libtasn1 < Package
  description 'Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.'
  homepage 'https://www.gnu.org/software/libtasn1/'
  version '4.12'
  source_url 'https://ftpmirror.gnu.org/libtasn1/libtasn1-4.12.tar.gz'
  source_sha256 '6753da2e621257f33f5b051cc114d417e5206a0818fe0b1ecfd6153f70934753'

  binary_url ({
  })
  binary_sha256 ({
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
