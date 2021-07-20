require 'package'

class Libsoup < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  @_ver = '2.99.8'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libsoup.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/2.99.8_armv7l/libsoup-2.99.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/2.99.8_armv7l/libsoup-2.99.8-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/2.99.8_i686/libsoup-2.99.8-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/2.99.8_x86_64/libsoup-2.99.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '41c08a29b640d95e648dee4fdbedcaefb18a422a49391cf39d5a45544ebde524',
     armv7l: '41c08a29b640d95e648dee4fdbedcaefb18a422a49391cf39d5a45544ebde524',
       i686: '98c6ba49cf0ab920eae0beec8c3298d298d0a5313f06fd6f4576caf1ae7b126f',
     x86_64: 'de2b3183bd4db56f1b945fb72c1fd9823adeda053c1be94d06dac93adf030870'
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
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
