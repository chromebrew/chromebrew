require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.69.2'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.69.2_armv7l/glib-2.69.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.69.2_armv7l/glib-2.69.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.69.2_i686/glib-2.69.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.69.2_x86_64/glib-2.69.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fe9ebe9afa704f979c17e75fa0d50bd28be4ca677c40ef789206d7422ba88d8e',
     armv7l: 'fe9ebe9afa704f979c17e75fa0d50bd28be4ca677c40ef789206d7422ba88d8e',
       i686: '18e9a61fbeed7d66d59ae1edc83f619557dbad6a89b537895f99bebf19f3c645',
     x86_64: '2e6b2d45f2db856c94427efdae401dd42018a65f650ce23e9e374fdde923c59c'
  })

  depends_on 'shared_mime_info' # L
  depends_on 'py3_six' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'util_linux' # R

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
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
