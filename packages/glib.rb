require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.66.3'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glib/2.66/glib-2.66.3.tar.xz'
  source_sha256 '79f31365a99cb1cc9db028625635d1438890702acde9e2802eae0acebcf7b5b1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.66.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.66.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.66.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.66.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1450f0c7ef950948050399c1f451e6cc5b59b1f6c5c451914e5a131106bac578',
     armv7l: '1450f0c7ef950948050399c1f451e6cc5b59b1f6c5c451914e5a131106bac578',
       i686: '1d02625673d3e8d8b7bbc18bbac153d4c1a39058427df6aa0dbf1d1a38ea20bf',
     x86_64: '1565316bfa555fb78a492202678c7715bf458dfc68da0d22b9e78f36ca16421e',
  })


  depends_on 'util_linux'
  depends_on 'six'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} -Dinternal_pcre=true -Diconv=external builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
