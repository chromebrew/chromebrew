require 'package'

class Startup_notification < Package
  description 'Library for tracking application startup'
  homepage 'http://www.freedesktop.org'
  version '0.12-1'
  compatibility 'all'
  source_url 'https://freedesktop.org/software/startup-notification/releases/startup-notification-0.12.tar.gz'
  source_sha256 '3c391f7e930c583095045cd2d10eb73a64f085c7fde9d260f2652c7cb3cfbe4a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c6a0bf1e9af0ac20da92a9c4e2bde6fa48cfbdc7a5b6e436aaf2814472ec9914',
     armv7l: 'c6a0bf1e9af0ac20da92a9c4e2bde6fa48cfbdc7a5b6e436aaf2814472ec9914',
       i686: '23ed0fa58d54e3d04c068e4cf591c292a5ae1ee56093349e35adb7eab47e5f7e',
     x86_64: 'b8fa364b3a6cd8c9f9c1cf18782086de55cea6354200448aa5c6d96f4f840b38',
  })

  depends_on 'xcb_util'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
