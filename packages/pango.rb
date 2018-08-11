require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.42'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.42/pango-1.42.0.tar.xz'
  source_sha256 '9924d88a3dcedff753f0763814a1605307c5c9c931413b8b47ea7267d1b19446'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.42-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.42-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.42-chromeos-x86_64.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.42-chromeos-i686.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd3ae54ce241076daf702da970558d1cb613f440837be96c9ddfc8a5ad163e206',
     armv7l: 'd3ae54ce241076daf702da970558d1cb613f440837be96c9ddfc8a5ad163e206',
     x86_64: '29b5123250755f822017786ea6caef3719f1fc6271e8d25b93ce35bc3c914bac',
       i686: 'deddc56994ca366f1b8e371503378361aae138deea46cc278dcb6ba33096c2ff',
  })

  depends_on 'harfbuzz'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gobject_introspection'   # add this package to build gtk+, avoid compilation error
  depends_on 'fribidi'
  depends_on 'six'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
