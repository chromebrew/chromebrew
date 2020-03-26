require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.64.0'
  source_url 'https://ftp.acc.umu.se/pub/gnome/sources/gobject-introspection/1.64/gobject-introspection-1.64.0.tar.xz'
  source_sha256 'eac05a63091c81adfdc8ef34820bcc7e7778c5b9e34734d344fc9e69ddf4fc82'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'
  depends_on 'cairo'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
