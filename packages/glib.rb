require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.67.4'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glib/2.67/glib-2.67.4.tar.xz'
  source_sha256 '8d87b962032dadfcae8df62d248aa91fed2c7a43faf2c6d8b9107eb6c50e5b14'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7d15e68503124e82d4ad52755dda9ff290572c84d17fc7d56d6eebdb4e261ae3',
     armv7l: '7d15e68503124e82d4ad52755dda9ff290572c84d17fc7d56d6eebdb4e261ae3',
       i686: '9031f7b19185505460005ea15589a6e52f7cc5ace50760b9154772d1c8951244',
     x86_64: '1d2e776143a13ea6b2e6b12709f72f4be628e55323dd39cea69ba0a7e92c43ca'
  })

  depends_on 'shared_mime_info'
  depends_on 'util_linux'
  depends_on 'six'
  depends_on 'pygments'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Das_needed=false \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
