# Adapted from Arch Linux tracker3 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3/trunk/PKGBUILD

require 'package'

class Tracker3 < Package
  description 'Desktop-neutral user information store, search tool and indexer'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.5.0'
  license 'GPLv2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/tracker.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.5.0_armv7l/tracker3-3.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.5.0_armv7l/tracker3-3.5.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.5.0_i686/tracker3-3.5.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.5.0_x86_64/tracker3-3.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3a8b373d7264681df1abd2cab31df0b4b55b2b094ecf3418d4a4daefca2b1e5b',
     armv7l: '3a8b373d7264681df1abd2cab31df0b4b55b2b094ecf3418d4a4daefca2b1e5b',
       i686: '63eac259d495420d057634e1eba55c6ab3d1e4c63e25cfc37b75a224e0b78c2b',
     x86_64: '24773226fab94d1f5fc9f9da4fa8e347d790717be6177451696bb700105aaf38'
  })

  depends_on 'asciidoc' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcc' # R
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
