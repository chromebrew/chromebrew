require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.13.2'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.13.2.tar.gz'
  source_sha256 '945deb349a7e2999184827c17351c1bf93c6395b9c3ade0c91cad42cb93435b1'

  depends_on 'expat'

  def self.build
    system "sh autogen.sh"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
