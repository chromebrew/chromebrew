require 'package'

class Wayland_protocols < Package
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.17'
  source_url 'https://wayland.freedesktop.org/releases/wayland-protocols-1.17.tar.xz'
  source_sha256 'df1319cf9705643aea9fd16f9056f4e5b2471bd10c0cc3713d4a4cdc23d6812f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.17-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.17-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wayland_protocols-1.17-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '80803133d8eb93e1039801ca3db1bf33995cf0d3a00ddef4b94314af9be05783',
     armv7l: '80803133d8eb93e1039801ca3db1bf33995cf0d3a00ddef4b94314af9be05783',
       i686: '43beccb1c83723527f975f3c59b8aadc7f4f14a9f57a90deda4bd81a3cb568aa',
     x86_64: '9de19df7a57cb6a179d716a0eab6b86842b79048399fdb714ba2ba6bc9be6e1f',
  })

  depends_on 'wayland'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
