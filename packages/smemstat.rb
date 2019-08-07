require 'package'

class Smemstat < Package
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'http://kernel.ubuntu.com/~cking/smemstat/'
  version '0.02.04'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/smemstat/smemstat-0.02.04.tar.xz'
  source_sha256 '108c2d76da762c9d8c50d87b3a58f3b4e44858dd8961a1f2681faa37aca56dce'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.04-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.04-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.04-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.04-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a180f274a3ca85169e81d1b41293459258ad82d2e1e23c562bb45afd56cb1c3c',
     armv7l: 'a180f274a3ca85169e81d1b41293459258ad82d2e1e23c562bb45afd56cb1c3c',
       i686: '9be911ef92621d73cfa3ed6f9794d2deb2a9fb38db9116fcc6eb7d2990922ede',
     x86_64: '0190150afb6f00f1fafa599056673f00b8a4a838c220fd2ba7a50a488337d549',
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
