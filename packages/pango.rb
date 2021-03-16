require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.48.3'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/pango/1.48/pango-1.48.2.tar.xz'
  source_sha256 'd21f8b30dc8abdfc55de25656ecb88dc1105eeeb315e5e2a980dcef8010c2c80'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c4bc39bde5db09cb6762d6fda0e9d454302f9484c71a3df677562b2db1407716',
     armv7l: 'c4bc39bde5db09cb6762d6fda0e9d454302f9484c71a3df677562b2db1407716',
       i686: '09b5c60ba73ebea3a95c0b7d2676e4ae5a7647825ffacebf6b0195c944680f36',
     x86_64: '0e334cadaaa118649dec9a8a35a6982f349338bed3c974fa3992786bf329b906'
  })

  depends_on 'harfbuzz'
  depends_on 'freetype'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gobject_introspection' # add this package to build gtk+, avoid compilation error
  depends_on 'libxrender'
  depends_on 'fribidi' # Gets built inside install automatically.
  depends_on 'six'
  depends_on 'fontconfig'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dinstall-tests=false \
    -Dcairo=enabled \
    -Dfreetype=enabled \
    -Dfontconfig=enabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
