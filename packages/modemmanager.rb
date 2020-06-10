require 'package'

class Modemmanager < Package
  description 'ModemManager is a DBus-activated daemon which controls mobile broadband (2G/3G/4G) devices and connections.'
  homepage 'https://www.freedesktop.org/wiki/Software/ModemManager/'
  version '1.8.2'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/ModemManager/ModemManager-1.8.2.tar.xz'
  source_sha256 '96f2a5f0ed15532b4c4c185b756fdc0326e7c2027cea26a1264f91e098260f80'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/modemmanager-1.8.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/modemmanager-1.8.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/modemmanager-1.8.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/modemmanager-1.8.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fafa7f2a98d6d68491db64205063c636a24662a8097c303d73e0b2ab660d0800',
     armv7l: 'fafa7f2a98d6d68491db64205063c636a24662a8097c303d73e0b2ab660d0800',
       i686: '18c4897f2fa06868b3b39c1b06c7351ef42f05629c33011f17c837d9c6206593',
     x86_64: 'bb5304352a96304749c0f969e24dde97e2c58a307f73ed53882afdb293648f55',
  })

  depends_on 'libmbim'
  depends_on 'libqmi'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
