require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.13.18'
  compatibility 'all'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.13.18.tar.xz'
  source_sha256 '8078f5c25e34ab907ce06905d969dc8ef0ccbec367e1e1707c7ecf8460f4254e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '11c36243a83f99f7a2f44194ed1e8691fc5a4dd98238a067e8fa8caf53364842',
     armv7l: '11c36243a83f99f7a2f44194ed1e8691fc5a4dd98238a067e8fa8caf53364842',
       i686: 'cfa8bf8ea807e3b6762a041419ffd39ce6c4888a430debb0b6a4c9aa55a63489',
     x86_64: 'c777f379f48d88844a5f9eb1f9e38174df8645c6e76845ab0fc8f1ee58034c52',
  })

  depends_on 'expat'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-doxygen-docs',
           '--disable-xml-docs'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
