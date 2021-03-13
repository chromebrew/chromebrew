require 'package'

class Libsoup < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  @_ver = '2.99.1'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/libsoup/#{@_ver_prelastdot}/libsoup-#{@_ver}.tar.xz"
  source_sha256 '9703c09e1b41d413bc17b5a3b8baac7cd8be1aa89ebd628de802d9a572dc8d44'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.99.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.99.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.99.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.99.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '94593ee64f8dfa68a432dd827f81ab189016a375541c5b52408ba6cd941fdcc6',
     armv7l: '94593ee64f8dfa68a432dd827f81ab189016a375541c5b52408ba6cd941fdcc6',
       i686: 'c1aac13d94d0a7ab3621a8d8cf75ce3d16afbab6de2452314913136b86213efc',
     x86_64: 'e471e82d56d33f1ea7765d287184c481528b1c7277bc703f00bca36a8c928400'
  })

  depends_on 'glib_networking'
  depends_on 'vala'
  depends_on 'libsoup2' # This way we make sure packages which need the older libsoup-2.4 library get it too.

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
