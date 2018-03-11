require 'package'

class Librsvg < Package
  description 'Scalable Vector Graphics (SVG) rendering library. https://wiki.gnome.org/Projects/LibRsvg'
  homepage 'https://download.gnome.org/sources/librsvg/'
  version '2.42.3'
  source_url 'https://download.gnome.org/sources/librsvg/2.42/librsvg-2.42.3.tar.xz'
  source_sha256 '704f2c44b9b170fc5498de36a161d01ca8f584ba9c42654b98565a7b7bcbe657'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'gtk_doc'
  depends_on 'vala'
  depends_on 'cairo'
  depends_on 'pango'
  depends_on 'libxml2'
  depends_on 'libcroco'
  depends_on 'rust'
  depends_on 'gdk_pixbuf'
  depends_on 'gobject_introspection'
  depends_on 'gtk3'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
 end
  
end
