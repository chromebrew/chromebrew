require 'package'

class Libsoup2 < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '2.74.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libsoup.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup2/2.74.0_armv7l/libsoup2-2.74.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup2/2.74.0_armv7l/libsoup2-2.74.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup2/2.74.0_x86_64/libsoup2-2.74.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '455f9d65631baf563d599f0cbe4d90b50545602e93d2773299c4434e12ada3b5',
     armv7l: '455f9d65631baf563d599f0cbe4d90b50545602e93d2773299c4434e12ada3b5',
     x86_64: '3194e26077e8343919de6492c83399c8f7e353b48c6b9a17c15b024a7dfb2621'
  })

  depends_on 'glib_networking'
  depends_on 'libevent'
  depends_on 'qtbase'
  depends_on 'vala'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dtests=false \
      -Dsysprof=disabled \
      -Dintrospection=enabled \
      builddir"
    system 'meson configure builddir'
    system "sed -i 's#-R#-Wl,-rpath=#g' builddir/build.ninja"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
