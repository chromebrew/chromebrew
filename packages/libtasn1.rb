require 'package'

class Libtasn1 < Package
  description 'Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.'
  homepage 'https://www.gnu.org/software/libtasn1/'
  version '4.10-2'
  source_url 'http://ftpmirror.gnu.org/libtasn1/libtasn1-4.10.tar.gz'
  source_sha256 '681a4d9a0d259f2125713f2e5766c5809f151b3a1392fd91390f780b4b8f5a02'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libtasn1-4.10-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libtasn1-4.10-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libtasn1-4.10-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libtasn1-4.10-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2d0af019e1690fea1f7b277a008783713f4d3535f54bc04fb6cd785606006f66',
     armv7l: '2d0af019e1690fea1f7b277a008783713f4d3535f54bc04fb6cd785606006f66',
       i686: '3fb18df6adf7689a405a45b009a9f496250fa462ce27db5ab778edd725149416',
     x86_64: '99e35599977b8cff5e69b6733b09c40f7a3cbf260699c3e427987ad8e841d6a2',
  })

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
