require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.12.2'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.12.2.tar.gz'
  source_sha256 '272bb5091770b047c8188b926d5e6038fa4fe6745488b2add96b23e2d9a83d88'

  depends_on 'expat'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
