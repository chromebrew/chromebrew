require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.66.3'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glib/2.66/glib-2.66.3.tar.xz'
  source_sha256 '79f31365a99cb1cc9db028625635d1438890702acde9e2802eae0acebcf7b5b1'


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
