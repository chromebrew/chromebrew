require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.67.0'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glib/2.67/glib-2.67.0.tar.xz'
  source_sha256 '0b15e57ab6c2bb90ced4e24a1b0d8d6e9a13af8a70266751aa3a45baffeed7c1'


  depends_on 'util_linux'
  depends_on 'six'
  depends_on 'libiconv'
  
  ENV['LDFLAGS'] = "-liconv"

  def self.build
    system "meson #{CREW_MESON_OPTIONS} -Dinternal_pcre=true builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
