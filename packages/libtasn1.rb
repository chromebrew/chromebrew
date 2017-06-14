require 'package'

class Libtasn1 < Package
  description 'Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.'
  homepage 'https://www.gnu.org/software/libtasn1/'
  version '4.10-1'
  source_url 'http://ftpmirror.gnu.org/libtasn1/libtasn1-4.10.tar.gz'
  source_sha1 'c7b36fa50866bbc889f7503c7fd1e9f9d7c52a64'

  # bison, diff, cmp are required at compile-time
  depends_on 'buildessential' => :build
  depends_on 'pkgconfig' => :build
  depends_on 'bison' => :build
  depends_on 'diffutils' => :build

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic", "--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
