require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.11.14'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.11.14.tar.gz'
  source_sha256 '55cfc7fdd2cccb2fce1f75d2132ad4801b5ed6699fc2ce79ed993574adf90c80'

  depends_on 'expat'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
