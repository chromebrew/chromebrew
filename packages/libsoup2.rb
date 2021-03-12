require 'package'

class Libsoup2 < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '2.72'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/libsoup/2.72/libsoup-2.72.0.tar.xz'
  source_sha256 '170c3f8446b0f65f8e4b93603349172b1085fb8917c181d10962f02bb85f5387'

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
