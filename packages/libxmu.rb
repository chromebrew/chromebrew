require 'package'

class Libxmu < Package
  description 'X.org X interface library for miscellaneous utilities not part of the Xlib standard'
  homepage 'http://www.x.org'
  version '1.1.2'
  source_url 'https://www.x.org/archive/individual/lib/libXmu-1.1.2.tar.gz'
  source_sha256 'e5fd4bacef068f9509b8226017205040e38d3fba8d2de55037200e7176c13dba'

  depends_on 'libxt'
  depends_on 'libxext'
  depends_on 'util_macros'
  depends_on 'libx11' 
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end