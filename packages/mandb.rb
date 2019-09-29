require 'package'

class Mandb < Package
  description 'mandb is used to initialise or manually update index database caches that are usually maintained by man.'
  homepage 'http://savannah.nongnu.org/projects/man-db'
  version '2.8.6.1'
  source_url 'https://download.savannah.gnu.org/releases/man-db/man-db-2.8.6.1.tar.xz'
  source_sha256 '2c77a2bb9dbf06f72417a6f63063e204888a22a5020ff77334d304d55f813a28'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}",
      "--with-systemdtmpfilesdir=#{CREW_PREFIX}/etc/tmpfiles.d", # we can't write to /usr/lib/tmpfiles.d
      '--disable-cache-owner',                                   # we can't create the user 'man'
      "--with-pager=#{CREW_PREFIX}/bin/less"                     # the pager is not at the default location
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/cache/man"
    [
      'include/manconfig.h.in',
      'src/manp.c',
      'src/tests/mandb-7',
      'src/man_db.conf.in',
      'manual/db.me',
      'manual/files.me',
      'man/man1/whatis.man1',
      'man/man1/apropos.man1',
      'man/man1/man.man1',
      'man/man8/accessdb.man8',
      'man/man8/mandb.man8',
      'tools/chconfig'
    ].each { |file|
      system "sed -i 's,/var/cache/man,#{CREW_PREFIX}/cache/man,g' #{file}"
    }
    system "sed -i 's,/usr/share/man,#{CREW_PREFIX}/share/man,g' tools/chconfig"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "To create the man databases and get apropos working, type 'mandb -c'.".lightblue
    puts
  end
end
