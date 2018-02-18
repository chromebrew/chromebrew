require 'package'

class Libxcomposite < Package
  description 'X.org X Composite Library'
  homepage 'http://www.x.org'
  version '0.4.4'
  source_url 'https://www.x.org/archive/individual/lib/libXcomposite-0.4.4.tar.gz'
  source_sha256 '83c04649819c6f52cda1b0ce8bcdcc48ad8618428ad803fb07f20b802f1bdad1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '00bd04423ca18062801954d921ca5a5bec6f20bf19a3b1bf565131b68348e3e4',
     armv7l: '00bd04423ca18062801954d921ca5a5bec6f20bf19a3b1bf565131b68348e3e4',
       i686: 'acd307b13fe243b4337563051594cb80c899c42ffcd02458a4816604075358bb',
     x86_64: '6d241e46fa5e691da0d14978277a8ae64daffd0eafdb63655d19925cf4e33093',
  })

  depends_on 'compositeproto'
  depends_on 'fixesproto'
  depends_on 'libxfixes'
  depends_on 'libxext'
  depends_on 'util_macros'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
