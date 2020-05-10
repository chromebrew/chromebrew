require 'package'

class Libtasn1 < Package
  description 'Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.'
  homepage 'https://www.gnu.org/software/libtasn1/'
  version '4.13'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libtasn1/libtasn1-4.13.tar.gz'
  source_sha256 '7e528e8c317ddd156230c4e31d082cd13e7ddeb7a54824be82632209550c8cca'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtasn1-4.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b445e57a2882b410e6b8493c7997a34d01bec701f67eb0654aa92d114c61ed8',
     armv7l: '5b445e57a2882b410e6b8493c7997a34d01bec701f67eb0654aa92d114c61ed8',
       i686: '89e4bf3ab1bd6c561209dd3e1cf298af0a8498cdae6a0b3c270ecfc84392bc4a',
     x86_64: '51009ec44bf8f51a3fc0432d78f14716b18d99eb99ad9b3b073079b5d168d1b9',
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
