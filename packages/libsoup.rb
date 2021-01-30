require 'package'

class Libsoup < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '2.72-2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/libsoup/2.72/libsoup-2.72.0.tar.xz'
  source_sha256 '170c3f8446b0f65f8e4b93603349172b1085fb8917c181d10962f02bb85f5387'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'b400c7ec6e46aa72743e94f1f04c1e91dfac90f4c6af9a02a7b1b7fd7ae1b9c2',
      armv7l: 'b400c7ec6e46aa72743e94f1f04c1e91dfac90f4c6af9a02a7b1b7fd7ae1b9c2',
        i686: '4e3fd0b050b6d9f6897df32eb13922ceeeac11934fbbfb1df65fd0677ff9af54',
      x86_64: '0a16a6d71b389a7196a93af1c4d29fa8c5c2d68dff6cd1b80b909de1d499de26',
  })

  depends_on 'glib_networking'
  depends_on 'libpsl'
  depends_on 'sqlite'
  depends_on 'vala'
  depends_on 'llvm'

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
