require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.70.2'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.2_armv7l/glib-2.70.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.2_armv7l/glib-2.70.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.2_i686/glib-2.70.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.2_x86_64/glib-2.70.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '03c4b687563f3dafb44902fdecad9e6ac93d786a354457b0f741060e3a375733',
     armv7l: '03c4b687563f3dafb44902fdecad9e6ac93d786a354457b0f741060e3a375733',
       i686: '46380d4b372b6003f508f289c48efb5a7f53700a620b376668bf5017ab55fda8',
     x86_64: '57c39aafee33dbab4fc73beb7087054ae8bd98d845f8954bf1f3e86edb83b0d8'
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

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
