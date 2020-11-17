require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.13.18'
  compatibility 'all'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.13.18.tar.xz'
  source_sha256 '8078f5c25e34ab907ce06905d969dc8ef0ccbec367e1e1707c7ecf8460f4254e'

  binary_url ({
  })
  binary_sha256 ({
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
