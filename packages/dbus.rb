require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.13.2'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.13.2.tar.gz'
  source_sha256 '945deb349a7e2999184827c17351c1bf93c6395b9c3ade0c91cad42cb93435b1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd57030c6ea1f7357dc1005374f185cdb4281b2eaa65f2dfaaa977b103c06e322',
     armv7l: 'd57030c6ea1f7357dc1005374f185cdb4281b2eaa65f2dfaaa977b103c06e322',
       i686: 'f08b4f22f911d553019b6729958c0357c13f0bda8f075b5c4c22a1a3cb30f066',
     x86_64: '16945f1e1ad2441e1eaf5c5ddd63b187cbda5447b75910102d6e1cfd6ffc2b3a',
  })

  depends_on 'expat'

  def self.build
    system "./configure \
    --prefix=#{CREW_PREFIX} \
    --libdir=#{CREW_LIB_PREFIX} \
    --disable-static \
    --disable-doxygen-docs \
    --disable-xml-docs"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
