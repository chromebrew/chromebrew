require 'package'

class Libsoup < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '2.72-1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/libsoup/2.72/libsoup-2.72.0.tar.xz'
  source_sha256 '170c3f8446b0f65f8e4b93603349172b1085fb8917c181d10962f02bb85f5387'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '5d2d945cb0778e402e8454807d5a45b4acdfa12b1bbcbe043e5c254888814871',
      armv7l: '5d2d945cb0778e402e8454807d5a45b4acdfa12b1bbcbe043e5c254888814871',
        i686: '52dc51da106b10daecda40a9cf445b0365dd253d730fe0f2e26906154b012814',
      x86_64: 'aad2a28eadfa2a21e4838b6bbe4301e1e97b5333d165c5264d0af289fa2229e7',
  })


  depends_on 'glib_networking'
  depends_on 'libpsl'
  depends_on 'sqlite'
  depends_on 'vala'
  depends_on 'llvm'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} -Dtests=false \
    -Dsysprof=disabled \
    -Dintrospection=disabled \
    builddir"
    system 'meson configure builddir'
    system "sed -i 's#-R#-Wl,-rpath=#g' builddir/build.ninja"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
