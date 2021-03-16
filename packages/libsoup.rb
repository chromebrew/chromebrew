require 'package'

class Libsoup < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  @_ver = '2.99.2'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/libsoup/#{@_ver_prelastdot}/libsoup-#{@_ver}.tar.xz"
  source_sha256 '664fa1b78a15cc0aa1fa65efb3b281a888417530f9f56a219571c0630f942ba5'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.99.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.99.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.99.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.99.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7b0fd36b36395b4949af7915af3eab02ab1842ba085f7c1858c977aca4af0534',
     armv7l: '7b0fd36b36395b4949af7915af3eab02ab1842ba085f7c1858c977aca4af0534',
       i686: '994478c3f30ed64b0ec04dc13b1383086806c8607f644a541bb4f25de2440a15',
     x86_64: '2226f557f9d63cf666a17edd10c0831589cd3bdd652774f77b8ae73d0caa6440'
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
