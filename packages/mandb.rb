require 'package'

class Mandb < Package
  description 'mandb is used to initialise or manually update index database caches that are usually maintained by man.'
  homepage 'http://savannah.nongnu.org/projects/man-db'
  version '2.8.4'
  source_url 'https://download.savannah.gnu.org/releases/man-db/man-db-2.8.4.tar.xz'
  source_sha256 '103c185f9d8269b9ee3b8a4cb27912b3aa393e952731ef96fedc880723472bc3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.8.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.8.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.8.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.8.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ff27c031abd6c775bdf8eb25f3655fe4b2cd91963e1d7779527d8fd9ad692c79',
     armv7l: 'ff27c031abd6c775bdf8eb25f3655fe4b2cd91963e1d7779527d8fd9ad692c79',
       i686: '6a403dd38647e742a9affc1ac831c9dbacfaa55aa09db127f51d6fc331214d99',
     x86_64: '0f3b5fee5e9b90e93f2242033cf7a49cd9100cf8b355e3abe4ba6f0d2f51b733',
  })

  depends_on 'libpipeline'
  depends_on 'gdbm'
  depends_on 'groff'
  depends_on 'readline'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}",
      "--with-systemdtmpfilesdir=#{CREW_PREFIX}/etc/tmpfiles.d", # we can't write to /usr/lib/tmpfiles.d
      '--disable-cache-owner',                                   # we can't create the user 'man'
      "--with-pager=#{CREW_PREFIX}/bin/less"                     # the pager is not at the default location
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/cache/man"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' include/manconfig.h.in"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' src/manp.c"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' src/tests/mandb-7"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' src/man_db.conf.in"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' init/systemd/man-db.conf"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' manual/db.me"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' manual/files.me"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' man/man1/whatis.man1"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' man/man1/apropos.man1"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' man/man1/man.man1"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' man/man8/accessdb.man8"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' man/man8/mandb.man8"
    system "sed -i 's,/usr/share/man,#{CREW_PREFIX}/share/man,g' tools/chconfig"
    system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' tools/chconfig"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To finish the installation, set the default MANPATH environment variable:".lightblue
    puts "echo \"export MANPATH=#{CREW_PREFIX}/man:$MANPATH\" >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To create the man databases and get apropos working, type 'mandb -c'.".lightblue
    puts
  end
end
