require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '2.40.1'
  source_url 'https://gitlab.com/graphviz/graphviz/repository/67cd2e5121379a38e0801cc05cce5033f8a2a609/archive.tar.bz2'
  source_sha256 '8dddc80b4194b17c1a5bc1cc7b5e001e9a3ec27272287dc16f278c736a29a9b9'

  depends_on 'automake' => :build
  depends_on 'fontconfig'
  depends_on 'pango'
  depends_on 'flex'
  depends_on 'gdk_pixbuf'
  depends_on 'libxrender'
  depends_on 'poppler'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
