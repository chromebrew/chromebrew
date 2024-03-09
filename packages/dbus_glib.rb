require 'package'

class Dbus_glib < Package
  description 'An obsolete, primarily unmaintained glib binding for libdbus.'
  homepage 'https://dbus.freedesktop.org/doc/dbus-glib/index.html'
  version '0.112'
  license 'GPL-2 or AFL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.112.tar.gz'
  source_sha256 '7d550dccdfcd286e33895501829ed971eeb65c614e73aadb4a08aeef719b143a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc2cea782f496613cd24b9f27afc015f5a02ebc73f63221f581c6bb5248bf8c9',
     armv7l: 'dc2cea782f496613cd24b9f27afc015f5a02ebc73f63221f581c6bb5248bf8c9',
     x86_64: 'a1258d16b859c3ff11591871e97b8ad4ddb33ac45951931b196368a613451d76'
  })

  depends_on 'dbus'
  depends_on 'glib'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
