require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.44.7'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.44/pango-1.44.7.tar.xz'
  source_sha256 '66a5b6cc13db73efed67b8e933584509f8ddb7b10a8a40c3850ca4a985ea1b1f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.44.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.44.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.44.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.44.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ec4d228e60636eaeae2f60a9d15d30685dfaba9b9664b633956bd2cf910f4aa1',
     armv7l: 'ec4d228e60636eaeae2f60a9d15d30685dfaba9b9664b633956bd2cf910f4aa1',
       i686: '6393f959ff12bafce05ba84eb60a1143bdd78cd2afdc56477d663f8ddd914db4',
     x86_64: '535b15a6d6f7f0433b697565f1490901606803dc9af598655cb69aaf4da616b1',
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
