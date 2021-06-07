# Adapted from Arch Linux tracker3 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3/trunk/PKGBUILD

require 'package'

class Tracker3 < Package
  description 'Desktop-neutral user information store, search tool and indexer'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.1.1'
  license 'GPLv2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/tracker.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.1.1_armv7l/tracker3-3.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.1.1_armv7l/tracker3-3.1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.1.1_i686/tracker3-3.1.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.1.1_x86_64/tracker3-3.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f4ce0e7b77fba49df81c8f3ce91bd1d5cc467c54419f10f5b558a8c49e27860d',
     armv7l: 'f4ce0e7b77fba49df81c8f3ce91bd1d5cc467c54419f10f5b558a8c49e27860d',
       i686: '4289748dfa869bd172a7fae1b6cd3b9238116f31492584f5d887e4b80fa75159',
     x86_64: '09f9d96911095b5e00f4206a62e56b9e9bfb79fe46ac9206fadc213810dbe714'
  })

  depends_on 'asciidoc'
  depends_on 'docbook_xml'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib'
  depends_on 'libsoup'
  depends_on 'libsoup2'
  depends_on 'libstemmer'
  depends_on 'util_linux'
  depends_on 'vala' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
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
