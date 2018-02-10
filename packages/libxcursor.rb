require 'package'

class Libxcursor < Package
  description 'X.org X Cursor management library'
  homepage 'http://www.x.org'
  version '1.1.15'
  source_url 'https://www.x.org/archive/individual/lib/libXcursor-1.1.15.tar.gz'
  source_sha256 '449befea2b11dde58ba3323b2c1ec30550013bd84d80501eb56d0048e62251a1'

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
