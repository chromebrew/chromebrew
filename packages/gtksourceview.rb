require 'package'

class Gtksourceview < Package
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  version '4.6.0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gtksourceview/archive/4.6.0.tar.gz'
  source_sha256 '34008d2e2fa07355e58f6bb6e9ae970b1370fe95e17ba4b0650b473b4d41860c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtksourceview-4.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1cf5dee7a1e574ddfb02364a1fd05bc71a64644b44070b5704e3df0712ce9dea',
     armv7l: '1cf5dee7a1e574ddfb02364a1fd05bc71a64644b44070b5704e3df0712ce9dea',
       i686: '7e9b0644c2385801f413803dd5aace6fd8d28a374374797430cfabe371d7703d',
     x86_64: 'e292727fd829b94c40072d118ddd2a861528da4d272294d2dae4fde6081ffe80',
  })

  depends_on 'setuptools' => :build
  depends_on 'vala'
  depends_on 'gtk3'

  def self.build
    system "meson --buildtype=plain --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
