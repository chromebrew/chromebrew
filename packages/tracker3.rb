# Adapted from Arch Linux tracker3 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3/trunk/PKGBUILD

require 'package'

class Tracker3 < Package
  description 'Desktop-neutral user information store, search tool and indexer'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.1.0'
  license 'GPLv2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/tracker/-/archive/#{version}/tracker-#{version}.tar.bz2"
  source_sha256 'd673f7733753bfca965947e56fd66e61de4d9a931f354b0f74bd7d678bda50f3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tracker3-3.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tracker3-3.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tracker3-3.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tracker3-3.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c0dcefb67e57e81357d16a8ea36354968220e3c219afb221793d258d1a21830f',
     armv7l: 'c0dcefb67e57e81357d16a8ea36354968220e3c219afb221793d258d1a21830f',
       i686: '31efe2b60354b1c9a014b0108e090ea06c323c332f830288a9228c916c13cae2',
     x86_64: 'c0d20b9d905e7fc879ef68c4d4bcf52038fe9da308aa29cb5940f0ffb9fe8fc0'
  })

  depends_on 'asciidoc'
  depends_on 'docbook_xml'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'libsoup'
  depends_on 'libstemmer'
  depends_on 'util_linux'
  depends_on 'vala' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Ddocs=false \
      -Dman=false \
      -Dsystemd_user_services=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
