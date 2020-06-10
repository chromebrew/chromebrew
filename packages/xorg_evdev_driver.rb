require 'package'

class Xorg_evdev_driver < Package
  description 'The Xorg Evdev Driver package contains a Generic Linux input driver for the Xorg X server. It handles keyboard, mouse, touchpads and wacom devices, though for touchpad and wacom advanced handling, additional drivers are required.'
  homepage 'https://www.x.org'
  version '2.10.5'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/driver/xf86-input-evdev-2.10.5.tar.bz2'
  source_sha256 '9edaa6205baf6d2922cc4db3d8e54a7e7773b5f733b0ae90f6be7725f983b70d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_evdev_driver-2.10.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_evdev_driver-2.10.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_evdev_driver-2.10.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_evdev_driver-2.10.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '69b9c2a60e21804c4169b7e596a7fe3527dd4b82546dd0b7e69253b302d277e9',
     armv7l: '69b9c2a60e21804c4169b7e596a7fe3527dd4b82546dd0b7e69253b302d277e9',
       i686: 'e7736ea7242f41d4b9e0f73a1ee3c015ab72395984f4514f9eb81f5765edfe44',
     x86_64: '7f8aab503e08725b8c0271af7df95fa10b69cb907cfde990539565ca2c6588eb',
  })

  depends_on 'mtdev'
  depends_on 'libevdev'
  depends_on 'xorg_server' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
