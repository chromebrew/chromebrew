require 'package'

class Libsoup2 < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '2.72'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/libsoup/2.72/libsoup-2.72.0.tar.xz'
  source_sha256 '170c3f8446b0f65f8e4b93603349172b1085fb8917c181d10962f02bb85f5387'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup2-2.72-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup2-2.72-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup2-2.72-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup2-2.72-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5fe4849b14fab9bc1642f86faed10800d8693d5b1e73d591dcf2aacbaca962a5',
     armv7l: '5fe4849b14fab9bc1642f86faed10800d8693d5b1e73d591dcf2aacbaca962a5',
       i686: '17309548e1b4c495785bc70a5d87b985e28bbd47ef8c4aff0b665083d2bfc7ec',
     x86_64: '3925e8f5ca246afdb7cc1dcca708eb5d61a07bc977d1eb2c8cf447526b326c52'
  })

  depends_on 'glib_networking'
  depends_on 'libevent'
  depends_on 'qtbase'
  depends_on 'vala'

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
