require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '2.44.0'
  source_url 'https://gitlab.com/graphviz/graphviz/-/archive/2.44.0/graphviz-2.44.0.tar.bz2'
  source_sha256 'eaff61ce05bf8196c596097bab6310fa6e7e96ee908a199a4bc83fbd5e7082d6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3208ec940c22105f3f138933ef6924e31c9dd86cbd9cd90e6be6bb95378eea04',
     armv7l: '3208ec940c22105f3f138933ef6924e31c9dd86cbd9cd90e6be6bb95378eea04',
       i686: '4ec896b8ec6dea9115c4adece31aea21fbf8e6dda4851465e17aef301d556106',
     x86_64: '4065b2252f78f92802cfa2c7293ed6636d7cb71f33fbba9145e7c686d73b3f0d',
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
    system './autogen.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "LDFLAGS='-L#{CREW_LIB_PREFIX}'",
           "--with-gdlibdir=#{CREW_LIB_PREFIX}",
           "--with-gdincludedir=#{CREW_PREFIX}/include",
           '--enable-io=no',
           '--enable-tcl=no',
           '--enable-lua=no',
           '--enable-perl=no',
           '--with-libgd=yes',
           '--with-libexpat=yes'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
