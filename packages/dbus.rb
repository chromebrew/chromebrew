require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.13.12'
  compatibility 'all'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.13.12.tar.xz'
  source_sha256 '7588649b56dd257c6a5f85a8c45aa2dfdf9e99f4de3983710f452081ca43eca6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dbus-1.13.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bc3711b6214181b732f6c98024718845f326258a8c4e681b58b2e8436998909b',
     armv7l: 'bc3711b6214181b732f6c98024718845f326258a8c4e681b58b2e8436998909b',
       i686: '4a208ad455645a8ebfbc06b53d7aa3e9a149169afb18f8232645287bb61a2865',
     x86_64: '9e24a9f1c2a389491c5dd06dc59ca7748479d786a7f0f4ce3247cdd982813756',
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
