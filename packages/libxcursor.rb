require 'package'

class Libxcursor < Package
  description 'X.org X Cursor management library'
  homepage 'http://www.x.org'
  version '1.1.15'
  source_url 'https://www.x.org/archive/individual/lib/libXcursor-1.1.15.tar.gz'
  source_sha256 '449befea2b11dde58ba3323b2c1ec30550013bd84d80501eb56d0048e62251a1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.1.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.1.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.1.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.1.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bf39ec0fd945b6617bb38bd88bbd4b834df8bb6996de7bff8710a7df7d4b6e4a',
     armv7l: 'bf39ec0fd945b6617bb38bd88bbd4b834df8bb6996de7bff8710a7df7d4b6e4a',
       i686: 'd723ebdb2178a4d48c626ac061550efa62f2282496d740d7e93c263d2f77e222',
     x86_64: 'bf3d0f82c0a72818877362124a2039baff3fa5fa24d571c2293227c52d9db821',
  })

  depends_on 'fixesproto'
  depends_on 'libxrender'
  depends_on 'libxfixes'
  depends_on 'util_macros'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
