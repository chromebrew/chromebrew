require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '2.42.2'
  source_url 'https://gitlab.com/graphviz/graphviz/-/archive/2.42.2/graphviz-2.42.2.tar.bz2'
  source_sha256 '1daed697d9cdd7fac3b320336fa98dd3518dd211769301dc716869fc3d5409b1'

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

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} LDFLAGS='-L#{CREW_LIB_PREFIX}' --with-libgd=yes --with-gdincludedir=#{CREW_PREFIX}/include --with-gdlibdir=#{CREW_LIB_PREFIX} --enable-tcl=no --enable-lua=no --enable-perl=no --enable-io=no"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
