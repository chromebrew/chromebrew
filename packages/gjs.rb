require 'package'

class Gjs < Package
  description 'Javascript Bindings for GNOME'
  @_ver = '1.70.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'MIT and MPL-1.1, LGPL-2+ or GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gjs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.70.0_armv7l/gjs-1.70.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.70.0_armv7l/gjs-1.70.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.70.0_i686/gjs-1.70.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gjs/1.70.0_x86_64/gjs-1.70.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c7529e8c72b504c609c77485d0c2df0a0bae7a84399d9f239c0adb00e2a8d2d6',
     armv7l: 'c7529e8c72b504c609c77485d0c2df0a0bae7a84399d9f239c0adb00e2a8d2d6',
       i686: '5d83c97a75732e52da16bada1e8e3484b5ffe2226043096247e7acccaf90b83a',
     x86_64: '2431c3e3f578dd8570349140729630d7916d49f9cf0b127097cad2e0fdaa1fe5'
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
