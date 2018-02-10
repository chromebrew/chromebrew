require 'package'

class Libxcomposite < Package
  description 'X.org X Composite Library'
  homepage 'http://www.x.org'
  version '0.4.4'
  source_url 'https://www.x.org/archive/individual/lib/libXcomposite-0.4.4.tar.gz'
  source_sha256 '83c04649819c6f52cda1b0ce8bcdcc48ad8618428ad803fb07f20b802f1bdad1'

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
