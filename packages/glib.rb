require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.74.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.74.0_armv7l/glib-2.74.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.74.0_armv7l/glib-2.74.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.74.0_i686/glib-2.74.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.74.0_x86_64/glib-2.74.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4205a27eaa3e549cf17f1b8ea845ae95879c8ee06049bdae4f3968ef414125f2',
     armv7l: '4205a27eaa3e549cf17f1b8ea845ae95879c8ee06049bdae4f3968ef414125f2',
       i686: '5ef65a1320355c2c57078ee7ad80c5bdad3aade1916539b079ef9a5044c52b07',
     x86_64: '6deeb6fc9445a6ada5a1b2528f2a0406ae5d6ea8e90d5817511abec33c2a1d7a'
  })

  depends_on 'elfutils' # R
  depends_on 'libffi' # R
  depends_on 'pcre' # R
  depends_on 'py3_pygments' => :build
  depends_on 'py3_six' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R
  depends_on 'pcre2' # R
  no_env_options
  patchelf
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    -Dtests=false \
    builddir"
    system 'meson configure builddir'
    system 'mold -run ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
