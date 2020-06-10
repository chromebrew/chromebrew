require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'http://man-db.nongnu.org/'
  version '2.9.0'
  compatibility 'all'
  source_url 'http://download.savannah.gnu.org/releases/man-db/man-db-2.9.0.tar.xz'
  source_sha256 '5d4aacd9e8876d6a3203a889860c3524c293c38f04111a3350deab8a6cd3e261'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7545fe308e8b643c6c289650770392ff7499f08cf2be63f98b753c990c1d0b9b',
     armv7l: '7545fe308e8b643c6c289650770392ff7499f08cf2be63f98b753c990c1d0b9b',
       i686: 'e400afbddd2f8564e4cdee38ae17447d632c7fb9bdbd35c53b0ed653830c373d',
     x86_64: '3e898c4771564163d80eb207acbeec8ec04c8c7de25ae572c9a4de163cfa28af',
  })

  depends_on 'gdbm'
  depends_on 'groff'
  depends_on 'libpipeline'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}",
      "--with-systemdtmpfilesdir=#{CREW_PREFIX}/etc/tmpfiles.d", # we can't write to /usr/lib/tmpfiles.d
      '--disable-cache-owner',                                   # we can't create the user 'man'
      "--with-pager=#{CREW_PREFIX}/bin/most"                     # the pager is not at the default location
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/cache/man"
    [
      'include/manconfig.h.in',
      'src/manp.c',
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
    system 'mandb -c'
  end
end
