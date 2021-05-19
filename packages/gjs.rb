require 'package'

class Gjs < Package
  description 'Javascript Bindings for GNOME'
  @_ver = '1.68.1'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'MIT and MPL-1.1, LGPL-2+ or GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gjs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.68.1_armv7l/gjs-1.68.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.68.1_armv7l/gjs-1.68.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.68.1_i686/gjs-1.68.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.68.1_x86_64/gjs-1.68.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a44d907e21468900d3ac6e0ea326dc051e431dd2eedf3ea8f3fc1603b5b93d70',
     armv7l: 'a44d907e21468900d3ac6e0ea326dc051e431dd2eedf3ea8f3fc1603b5b93d70',
       i686: 'd1c8db6ed575dd5f471fc3c91e8c7f5f34e448ba8eca2c3aa8802eaf923f3ff3',
     x86_64: '0d0b81db80db509870491850ce86bc0b7b0aaca8407eb8d7c09e47797aa908ba'
  })

  depends_on 'cairo' # R
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'js78' => :build
  depends_on 'libx11' # R

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dinstalled_tests=false \
    -Dskip_dbus_tests=true \
    -Dreadline=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
