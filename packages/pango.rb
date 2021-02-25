require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.48.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/pango/1.48/pango-1.48.2.tar.xz'
  source_sha256 '08c2d550a96559f15fb317d7167b96df57ef743fef946f4e274bd8b6f2918058'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '48c6277c278e0bc48c09dd3e688a0ca2e36f79765c90ecddfd6d5b46869feff9',
     armv7l: '48c6277c278e0bc48c09dd3e688a0ca2e36f79765c90ecddfd6d5b46869feff9',
       i686: 'acef25d5de3d7c3f5c889a04cc29dff6192a66244fdce95306da40319b06cd1b',
     x86_64: '16c912f1381ecdf1fd5329ee8fd9e5c18cec87b91e714a899f17384b7ae5684b'
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
