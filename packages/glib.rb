require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.67.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glib/2.67/glib-2.67.1.tar.xz'
  source_sha256 '3b3409fe3a93f9e9f6f5dc9cd8405edfd7513b289589987e568369e627d3350c'


  depends_on 'pcre2'
  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'shared_mime_info'
  depends_on 'util_linux'
  depends_on 'six'
  
  ENV['CFLAGS'] = "-fno-stack-protector"
  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    -Dgtk_doc=false \
    -Diconv=external \
    -Dinternal_pcre=true \
    build"
    system "meson configure build"
    system "ninja -C build"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
