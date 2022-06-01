require 'package'

class Gjs < Package
  description 'Javascript Bindings for GNOME'
  @_ver = '1.71.1'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'MIT and MPL-1.1, LGPL-2+ or GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gjs.git'
  git_branch 'mozjs91'
  git_hashtag 'e41f247f8c170d125ce968ed236ae7249e966178'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.71.1_armv7l/gjs-1.71.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.71.1_armv7l/gjs-1.71.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.71.1_i686/gjs-1.71.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.71.1_x86_64/gjs-1.71.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f13e6ea4b094df81d3c48a0a46cc095651c43490785f4f40062078427899edb3',
     armv7l: 'f13e6ea4b094df81d3c48a0a46cc095651c43490785f4f40062078427899edb3',
       i686: '5bbb9d5c10377d3de0d388f2e9e65f0ad6c187e2d25ab29ebcf92cfcb58a6050',
     x86_64: '84cf5ab2dbe09170b7a60dc005988d97cbc573e064484935d91de910e3402d00'
  })

  depends_on 'cairo' # R
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'js91'
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
