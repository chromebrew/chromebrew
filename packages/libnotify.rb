require 'package'

class Libnotify < Package
  description 'A library for sending desktop notifications.'
  homepage 'https://git.gnome.org/browse/libnotify'
  @_ver = '0.7.9'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GNOME/libnotify/archive/#{@_ver}.tar.gz"
  source_sha256 '9bd4f5fa911d27567e7cc2d2d09d69356c16703c4e8d22c0b49a5c45651f3af0'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnotify-0.7.9-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnotify-0.7.9-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnotify-0.7.9-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnotify-0.7.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '06d8ab2630fbfae249c5bfb1e9dbd51cc57a7e1fe7c9b5297926cff9a9e4592b',
      armv7l: '06d8ab2630fbfae249c5bfb1e9dbd51cc57a7e1fe7c9b5297926cff9a9e4592b',
        i686: 'a12e7df177e5621731b8de4cdc714e6cc57a734e631445e4a501e7a81b90162b',
      x86_64: '23b869cb69ff53a1eee4d2b6cd6f622400f10030404a882471f5ecdb354b38ee',
  })

  depends_on 'gtk_doc'
  depends_on 'gtk3'
  depends_on 'gnome_common'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dman=false \
    -Ddocbook_docs=disabled \
    -Dtests=false \
    -Dgtk_doc=false \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
