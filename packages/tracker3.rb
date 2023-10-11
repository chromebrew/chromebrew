# Adapted from Arch Linux tracker3 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tracker3/trunk/PKGBUILD

require 'buildsystems/meson'

class Tracker3 < Meson
  description 'Desktop-neutral user information store, search tool and indexer'
  homepage 'https://wiki.gnome.org/Projects/Tracker'
  version '3.6.0'
  license 'GPLv2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/tracker.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.6.0_armv7l/tracker3-3.6.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.6.0_armv7l/tracker3-3.6.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tracker3/3.6.0_x86_64/tracker3-3.6.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7c61e7b8d0fb1be446a2c2db2060ff1b9a4349531d7df6cde4e91a1ec69ea4ec',
     armv7l: '7c61e7b8d0fb1be446a2c2db2060ff1b9a4349531d7df6cde4e91a1ec69ea4ec',
     x86_64: '26e3149df2d260e96f70c11e5f0e2b7aaed38fbc6545df7cd9a8262b161dfac1'
  })

  depends_on 'asciidoc' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
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

  meson_options "-Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Ddocs=false \
      -Dman=false \
      -Dsystemd_user_services=false"

  def self.preflight
    return if Gem::Version.new(LIBC_VERSION.to_s) > Gem::Version.new('2.34')

    abort "Tracker3 requires glibc 2.35. The current glibc version is #{LIBC_VERSION}.".lightred
  end
end
