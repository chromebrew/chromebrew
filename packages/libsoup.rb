require 'package'

class Libsoup < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  @_ver = '2.99.5'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libsoup.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/2.99.5_armv7l/libsoup-2.99.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/2.99.5_armv7l/libsoup-2.99.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/2.99.5_i686/libsoup-2.99.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/2.99.5_x86_64/libsoup-2.99.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4f50b3740fd20061dfe27d08ef6cfb0815fefdd8740e3f5b71e284617c51033b',
     armv7l: '4f50b3740fd20061dfe27d08ef6cfb0815fefdd8740e3f5b71e284617c51033b',
       i686: 'f4effaf7fb8acf0262edb3d199bb982e8de90283aee92463005cacd343738a23',
     x86_64: '28192705371f712fa67d4c6d17a7bd48114f3114882a5a499795bfe1d04c3dda'
  })

  depends_on 'glib_networking'
  depends_on 'vala'
  depends_on 'libsoup2' # This way we make sure packages which need the older libsoup-2.4 library get it too.

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
