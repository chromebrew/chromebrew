require 'package'

class Mandb < Package
  description 'mandb is used to initialise or manually update index database caches that are usually maintained by man.'
  homepage 'http://savannah.nongnu.org/projects/man-db'
  version '2.8.3'
  source_url 'https://download.savannah.gnu.org/releases/man-db/man-db-2.8.3.tar.xz'
  source_sha256 '5932a1ca366e1ec61a3ece1a3afa0e92f2fdc125b61d236f20cc6ff9d80cc4ac'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.8.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.8.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.8.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.8.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3729439a4b76560027ef642acbaa39512cd5e0c116905a07e04c6efcc3f63d60',
     armv7l: '3729439a4b76560027ef642acbaa39512cd5e0c116905a07e04c6efcc3f63d60',
       i686: '0c6b7b712c7a66588766d7a2c8fbba2577d9db68127f379c1fc19372f430cd94',
     x86_64: '0e49e640687ee7248437f7fa07aaa908674e94a03ae9232beb01a2e3744b1c56',
  })

  depends_on 'less'
  depends_on 'libpipeline'
  depends_on 'gdbm'
  depends_on 'groff'
  depends_on 'pkgconfig'
  depends_on 'readline'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
      "--with-systemdtmpfilesdir=#{CREW_PREFIX}/lib/tmpfiles.d", # we can't write to /usr/lib/tmpfiles.d
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
    puts "To finish the installation, set the default PAGER and MANPATH environment variables:".lightblue
    puts "echo \"export PAGER=#{CREW_PREFIX}/bin/less\" >> ~/.bashrc".lightblue
    puts "echo \"export MANPATH=#{CREW_PREFIX}/man:$MANPATH\" >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To create the man databases and get apropos working, type 'mandb -c'.".lightblue
    puts
  end
end
