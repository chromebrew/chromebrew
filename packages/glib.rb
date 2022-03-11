require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.71.3'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.3_armv7l/glib-2.71.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.3_armv7l/glib-2.71.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.3_i686/glib-2.71.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.71.3_x86_64/glib-2.71.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f790de63e82f702d061f2de152025f3f76294165c11b1412b914ef197876eed8',
     armv7l: 'f790de63e82f702d061f2de152025f3f76294165c11b1412b914ef197876eed8',
       i686: '9113fd3b36bbeba475fe1d02c30e3e5da480c1c0de9808a3ad3f0d4f4c2fe890',
     x86_64: 'd2fc753604c45fc397ebceadefca2b9db3aea42384c70237688df6d33e5b60d8'
  })

  depends_on 'elfutils' # R
  depends_on 'libffi' # R
  depends_on 'pcre' # R
  depends_on 'py3_pygments' => :build
  depends_on 'py3_six' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R
  no_env_options

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

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
