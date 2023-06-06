# Adapted from Arch Linux tracker3 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3/trunk/PKGBUILD

require 'package'

class Tracker3 < Package
  description 'Desktop-neutral user information store, search tool and indexer'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.5.3'
  license 'GPLv2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/tracker.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.5.3_armv7l/tracker3-3.5.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.5.3_armv7l/tracker3-3.5.3-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.5.3_x86_64/tracker3-3.5.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '418e1194ab2c3b06520ca4bc70734d2608d1eed30373de2a33672d7bb3ee941b',
     armv7l: '418e1194ab2c3b06520ca4bc70734d2608d1eed30373de2a33672d7bb3ee941b',
     x86_64: '8f3f2c5032e828955f781d757b401d6b6eff0aa3a681d8670aea61c82d750def'
  })

  depends_on 'asciidoc' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'icu4c' # R
  depends_on 'json_glib' # R
  depends_on 'libsoup2' # R
  depends_on 'libsoup' # R
  depends_on 'libstemmer' # R
  depends_on 'libxml2' # R
  depends_on 'pygobject' => :build
  depends_on 'sqlite' # R
  depends_on 'util_linux' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Ddocs=false \
      -Dman=false \
      -Dsystemd_user_services=false \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
