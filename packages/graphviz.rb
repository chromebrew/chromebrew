require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '2.40.1'
  source_url 'https://graphviz.gitlab.io/pub/graphviz/stable/SOURCES/graphviz.tar.gz'
  source_sha256 'ca5218fade0204d59947126c38439f432853543b0818d9d728c589dfe7f3a421'

  depends_on 'fontconfig'
  depends_on 'pango'
  depends_on 'flex'
  depends_on 'gdk_pixbuf'
  depends_on 'libxrender'
  depends_on 'popper'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
