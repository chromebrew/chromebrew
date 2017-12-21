require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.12.2'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.12.2.tar.gz'
  source_sha256 '272bb5091770b047c8188b926d5e6038fa4fe6745488b2add96b23e2d9a83d88'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.12.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.12.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.12.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.12.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '854f54dd96cbfbdd63c6108d66d96ae2ca7c15780296536646b91d447cf76ae7',
     armv7l: '854f54dd96cbfbdd63c6108d66d96ae2ca7c15780296536646b91d447cf76ae7',
       i686: '9c1fc9ca5f1704c2725d6639c52f2ee31de4dc7c3a4360d2670565eb711659aa',
     x86_64: 'ca87af2a65b2f1f48877446f0f02f7d2535d21a0797f067d45dab45bf5e2d558',
  })

  depends_on 'expat'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
