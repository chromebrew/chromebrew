require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.44.7'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.44/pango-1.44.7.tar.xz'
  source_sha256 '66a5b6cc13db73efed67b8e933584509f8ddb7b10a8a40c3850ca4a985ea1b1f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'harfbuzz'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gobject_introspection'   # add this package to build gtk+, avoid compilation error
  depends_on 'libxrender'
  depends_on 'fribidi'
  depends_on 'six'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
