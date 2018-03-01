require 'package'

class Mandb < Package
  description 'mandb is used to initialise or manually update index database caches that are usually maintained by man.'
  homepage 'http://savannah.nongnu.org/projects/man-db'
  version '2.7.6.1-2'
  source_url 'http://download.savannah.gnu.org/releases/man-db/man-db-2.7.6.1.tar.xz'
  source_sha256 '08edbc52f24aca3eebac429b5444efd48b9b90b9b84ca0ed5507e5c13ed10f3f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.7.6.1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.7.6.1-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.7.6.1-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.7.6.1-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd583e56cd4c924f328f2b0052de2d08b8f0e6519db7a6c9b232852bbca76f6bf',
     armv7l: 'd583e56cd4c924f328f2b0052de2d08b8f0e6519db7a6c9b232852bbca76f6bf',
       i686: '64ca4d1b671f87fa2fa72edc35368fe54ab5ca4d8fddbb99981b6179deb5fd88',
     x86_64: '37da9857a8e52bfb5ca02e672c2632eceba5eb42d331698c28d8c98029cf3351',
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
