require 'package'

class Libsoup < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '2.72'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/libsoup/2.72/libsoup-2.72.0.tar.xz'
  source_sha256 '170c3f8446b0f65f8e4b93603349172b1085fb8917c181d10962f02bb85f5387'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.72-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'db840c9c32887c274e4c985b88f8a680dc292ed879ac44851b215f9bcaf6fb72',
     armv7l: 'db840c9c32887c274e4c985b88f8a680dc292ed879ac44851b215f9bcaf6fb72',
       i686: '3fb8c1d5efb9dee130f592b1aae01adf28431e0bdbe9fb33d26026c938e2f74c',
     x86_64: 'aba1f475bb62d8fd61702d29054dd0e14d3eb27c0bbc819e25dc51ead23c5756',
  })

  depends_on 'glib_networking'
  depends_on 'libpsl'
  depends_on 'sqlite'
  depends_on 'vala'
  depends_on 'llvm'

  ENV['CC'] = 'clang'
  ENV['CXX'] = 'clang'
  def self.build
    system "meson #{CREW_MESON_OPTIONS} -Dtests=false \
    -Dsysprof=disabled \
    -Dintrospection=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
