require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.64.0'
  source_url 'https://ftp.acc.umu.se/pub/gnome/sources/gobject-introspection/1.64/gobject-introspection-1.64.0.tar.xz'
  source_sha256 'eac05a63091c81adfdc8ef34820bcc7e7778c5b9e34734d344fc9e69ddf4fc82'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.64.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.64.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.64.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.64.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '38781ac9905d88ebfcd5f776cdec1d7ff79b45b0f03dbf7e72e729a232175389',
     armv7l: '38781ac9905d88ebfcd5f776cdec1d7ff79b45b0f03dbf7e72e729a232175389',
       i686: '0244b19fa91d0524eceb40b1694ee3473d212d5cd9d3147fcb3e59406d98dbd6',
     x86_64: '10e3f341d3bbe14d741062463bc6eb0631051db075cef3782b3273191aea098b',
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
