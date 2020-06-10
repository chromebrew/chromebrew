require 'package'

class Librsvg < Package
  description 'Scalable Vector Graphics (SVG) rendering library.'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.42.3'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/librsvg/2.42/librsvg-2.42.3.tar.xz'
  source_sha256 '704f2c44b9b170fc5498de36a161d01ca8f584ba9c42654b98565a7b7bcbe657'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.42.3-chromeos-x86_64.tar.xz',
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.42.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.42.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/librsvg-2.42.3-chromeos-i686.tar.xz',
  })
  binary_sha256 ({
     x86_64: '36d8876ec5ce51fd153cda5a64e52586e4a9853e3428cd1c24cf5be60f3a95ac',
    aarch64: '692cdd07b2038a00220d1177a32692e56171188388282a4ca75a480ac26d78a2',
     armv7l: '692cdd07b2038a00220d1177a32692e56171188388282a4ca75a480ac26d78a2',
       i686: '2c590e62ab4bee72be2f8014c9b256d24fbdcf307c0f2ac44dcabee6c566cfdb',
  })

  depends_on 'gtk_doc'
  depends_on 'vala'
  depends_on 'cairo'
  depends_on 'pango'
  depends_on 'libcroco'
  depends_on 'gdk_pixbuf'
  depends_on 'gobject_introspection'
  depends_on 'gtk3'
  depends_on 'rust' => :build
  depends_on 'six' => :build

  def self.build
    system "rustup install stable"
    system "rustup default stable"
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--enable-introspection",
           "--enable-vala",
           "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
