require 'package'

class Argon2 < Package
  description 'The password hash Argon2, winner of PHC'
  homepage 'https://github.com/P-H-C/phc-winner-argon2'
  version '20171227'
  source_url 'https://github.com/P-H-C/phc-winner-argon2/archive/20171227.tar.gz'
  source_sha256 'eaea0172c1f4ee4550d1b6c9ce01aab8d1ab66b4207776aa67991eb5872fdcd8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/argon2-20171227-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/argon2-20171227-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/argon2-20171227-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/argon2-20171227-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6688f94b68d0541be8c03cbae3a5cd904d0a15c2fb84f9d2d8b0ffd1d7bfb643',
     armv7l: '6688f94b68d0541be8c03cbae3a5cd904d0a15c2fb84f9d2d8b0ffd1d7bfb643',
       i686: '545249fd01da7b62a00a4c2ecfb09b99423d98030f68111ae9f0e2b30cbad8ce',
     x86_64: '700fbeddc09b599c7525bb16487f3e73ece490e6e3ad92919baf3888af65464d',
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make',
           "PREFIX=#{CREW_PREFIX}",
           "LIBDIR=#{CREW_LIB_PREFIX}",
           "DESTDIR=#{CREW_DEST_DIR}",
           'install'
    system "install -Dm644 man/argon2.1 #{CREW_DEST_PREFIX}/share/man/man1/argon2.1"
  end
end
