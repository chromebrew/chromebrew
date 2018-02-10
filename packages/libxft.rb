require 'package'

class Libxft < Package
  description 'X.org X FreeType interface library'
  homepage 'http://www.x.org'
  version '2.3.2'
  source_url 'https://www.x.org/archive/individual/lib/libXft-2.3.2.tar.gz'
  source_sha256 '26cdddcc70b187833cbe9dc54df1864ba4c03a7175b2ca9276de9f05dce74507'

  depends_on 'libxrender'
  depends_on 'libx11' 
  depends_on 'fontconfig'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end