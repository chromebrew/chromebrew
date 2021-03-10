require 'package'

class Startup_notification < Package
  description 'Monitor and display application startup'
  homepage 'https://www.freedesktop.org'
  @_ver = '0.12'
  version "#{@_ver}-2"
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/startup-notification/releases/startup-notification-#{@_ver}.tar.gz"
  source_sha256 '3c391f7e930c583095045cd2d10eb73a64f085c7fde9d260f2652c7cb3cfbe4a'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/startup_notification-0.12-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8bd6a0275356eb6dd22ff8b5352354873cbba0e57f99864a52e853de3f9284c2',
     armv7l: '8bd6a0275356eb6dd22ff8b5352354873cbba0e57f99864a52e853de3f9284c2',
       i686: '028205aa25c3c3a082dbe1046a2c5c7b7e59e0ae38b819b6511c942cff2f19e2',
     x86_64: '85ac878ff6afeaa64b599b8a20b2615f95dbeb99f046c8f52bde474697d357ab'
  })

  depends_on 'libx11'
  depends_on 'xcb_util'

  def self.patch
    system "sed -i -e '/AC_PATH_XTRA/d' configure.in"
  end

  def self.build
    system 'autoreconf --force --install'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --localstatedir=/var \
      --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
