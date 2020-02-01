require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '2.42.2'
  source_url 'https://gitlab.com/graphviz/graphviz/-/archive/2.42.2/graphviz-2.42.2.tar.bz2'
  source_sha256 '1daed697d9cdd7fac3b320336fa98dd3518dd211769301dc716869fc3d5409b1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.42.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.42.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.42.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.42.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7950f9bf30b726d47e2a43b7617cd2cc01039a53faba377b5c8aa706e1b61a2f',
     armv7l: '7950f9bf30b726d47e2a43b7617cd2cc01039a53faba377b5c8aa706e1b61a2f',
       i686: 'dc786a500b658446e90f90e7e6b8aeb5165840f09964f12899cef19c8413a633',
     x86_64: 'b34bab2d96832ca42aaeeddad01637f4f0bab8705f7d49ef9a2488a7164d8451',
  })

  depends_on 'automake' => :build
  depends_on 'pango'
  depends_on 'flex'
  depends_on 'gdk_pixbuf'
  depends_on 'libxrender'
  depends_on 'poppler'
  depends_on 'tcl'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} LDFLAGS='-L#{CREW_LIB_PREFIX}' --with-libgd=yes --with-gdincludedir=#{CREW_PREFIX}/include --with-gdlibdir=#{CREW_LIB_PREFIX} --enable-tcl=no --enable-lua=no --enable-perl=no --enable-io=no"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
