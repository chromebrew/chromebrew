require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.48.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/pango/1.48/pango-1.48.1.tar.xz'
  source_sha256 '08c2d550a96559f15fb317d7167b96df57ef743fef946f4e274bd8b6f2918058'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.48.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'daa7da13785e86b3bfada7e83bcf17c89d5660e709f8a347aa86e3ccae932ab7',
      armv7l: 'daa7da13785e86b3bfada7e83bcf17c89d5660e709f8a347aa86e3ccae932ab7',
        i686: '8b6c14849997167ba526680b9876ce47dcf11509b0790ca8d00c74af1575ddcc',
      x86_64: 'a0fd7fd131fad159aeae6412a33bf23334966421808e279aaaa0881a216a1721',
  })

  depends_on 'harfbuzz'
  depends_on 'freetype'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gobject_introspection'   # add this package to build gtk+, avoid compilation error
  depends_on 'libxrender'
  depends_on 'fribidi' # Gets built inside install automatically.
  depends_on 'six'
  depends_on 'llvm' => ':build'
  depends_on 'fontconfig'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dinstall-tests=false \
    -Dcairo=enabled \
    -Dfreetype=enabled \
    -Dfontconfig=enabled \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
