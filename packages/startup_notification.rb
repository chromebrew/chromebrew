require 'package'

class Startup_notification < Package
  description 'Library for tracking application startup'
  homepage 'http://www.freedesktop.org'
  version '0.12'
  compatibility 'all'
  source_url 'https://freedesktop.org/software/startup-notification/releases/startup-notification-0.12.tar.gz'
  source_sha256 '3c391f7e930c583095045cd2d10eb73a64f085c7fde9d260f2652c7cb3cfbe4a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '731097a23182eb11aa6858425948fc29f616721189f6bfb1203ebffefba98965',
     armv7l: '731097a23182eb11aa6858425948fc29f616721189f6bfb1203ebffefba98965',
       i686: '4fb01aac0d158c6cbf866ecca912f592de05a43191ef87679f47bc1eede1d4e8',
     x86_64: '722f0cb744f3b4b947782fd22dec23e6c9459d4786196cb5798c6faa74219939',
  })
  
  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
