require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '2.44.0'
  source_url 'https://gitlab.com/graphviz/graphviz/-/archive/2.44.0/graphviz-2.44.0.tar.bz2'
  source_sha256 'eaff61ce05bf8196c596097bab6310fa6e7e96ee908a199a4bc83fbd5e7082d6'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'automake' => :build
  depends_on 'pango'
  depends_on 'flex'
  depends_on 'gdk_pixbuf'
  depends_on 'libxrender'
  depends_on 'poppler'
  depends_on 'tcl'
  depends_on 'expat'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} LDFLAGS='-L#{CREW_LIB_PREFIX}' --with-libgd=yes --with-gdincludedir=#{CREW_PREFIX}/include --with-gdlibdir=#{CREW_LIB_PREFIX} --enable-tcl=no --enable-lua=no --enable-perl=no --enable-io=no --with-libexpat=yes"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
