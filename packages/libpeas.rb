require 'package'

class Libpeas < Package
  description 'libpeas is a gobject-based plugins engine'
  homepage 'https://gitlab.gnome.org/GNOME/libpeas'
  version '1.22.0'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libpeas/-/archive/libpeas-1.22.0/libpeas-libpeas-1.22.0.tar.bz2'
  source_sha256 '8400f330f3ccc48e9d1702a40731e4deaa11310862a6a61cc25b67d375e2e572'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpeas-1.22.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpeas-1.22.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpeas-1.22.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpeas-1.22.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bf06c86dfa448a3e4848fb0c80c4f4611683fd1b631e27d4e3266148a8a9451e',
     armv7l: 'bf06c86dfa448a3e4848fb0c80c4f4611683fd1b631e27d4e3266148a8a9451e',
       i686: '7cd0e0a6aea97863d9bb3bb3735e53f4223cb33f59cfe1a8fe870dcb38675af1',
     x86_64: '1e5dab28a55d3e2209ed4535b0cbaf94c5260a79792a987d6ca9de19c3168952',
  })

  depends_on 'gobject_introspection'
  depends_on 'gnome_common'
  depends_on 'gtk_doc'
  depends_on 'gtk3'
  depends_on 'lua'
  depends_on 'pygobject'

  def self.build
    system "./autogen.sh --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
