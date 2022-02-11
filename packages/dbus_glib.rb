require 'package'

class Dbus_glib < Package
  description 'An obsolete, primarily unmaintained glib binding for libdbus.'
  homepage 'https://dbus.freedesktop.org/doc/dbus-glib/index.html'
  version '0.112'
  license 'GPL-2 or AFL-2.1'
  compatibility 'all'
  source_url 'https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.112.tar.gz'
  source_sha256 '7d550dccdfcd286e33895501829ed971eeb65c614e73aadb4a08aeef719b143a'

  depends_on 'dbus'
  depends_on 'glib'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
