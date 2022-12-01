# Adapted from Arch Linux tracker3 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3/trunk/PKGBUILD

require 'package'

class Tracker3 < Package
  description 'Desktop-neutral user information store, search tool and indexer'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.4.0.rc'
  license 'GPLv2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/tracker.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.4.0.rc_armv7l/tracker3-3.4.0.rc-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.4.0.rc_armv7l/tracker3-3.4.0.rc-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.4.0.rc_i686/tracker3-3.4.0.rc-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.4.0.rc_x86_64/tracker3-3.4.0.rc-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'abdf19bdb2bd2744dd67cb08f1518981e9b7480fb9b9c8a5e0ba839fee599473',
     armv7l: 'abdf19bdb2bd2744dd67cb08f1518981e9b7480fb9b9c8a5e0ba839fee599473',
       i686: '24b33cf2d548e0248033de66875e7325f255b1d466437030fbda8832457b5d7b',
     x86_64: 'e23b3ea2372e41898ee5a8e5eb38aaee70b3d19511513c8af74ca643603e2490'
  })

  depends_on 'asciidoc'
  depends_on 'docbook_xml'
  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib'
  depends_on 'libsoup'
  depends_on 'libsoup2'
  depends_on 'libstemmer'
  depends_on 'util_linux'
  depends_on 'vala' => :build
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'sqlite' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
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
