require 'package'

class Startup_notification < Package
  description 'Library for tracking application startup'
  homepage 'http://www.freedesktop.org'
  version '0.12'
  compatibility 'all'
  source_url 'https://freedesktop.org/software/startup-notification/releases/startup-notification-0.12.tar.gz'
  source_sha256 '3c391f7e930c583095045cd2d10eb73a64f085c7fde9d260f2652c7cb3cfbe4a'
  
  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
