require 'package'

class Mandb < Package
  description 'mandb is used to initialize or manually update index database caches that are usually maintained by man.'
  homepage 'http://man-db.nongnu.org/'
  version '2.9.3'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/man-db/man-db-2.9.3.tar.xz'
  source_sha256 'fa5aa11ab0692daf737e76947f45669225db310b2801a5911bceb7551c5597b8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mandb-2.9.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8bad5f96c6b1259cf8c13e72759bf13ddbd74cb76d3ea03a330b9b3b2da7bce6',
     armv7l: '8bad5f96c6b1259cf8c13e72759bf13ddbd74cb76d3ea03a330b9b3b2da7bce6',
       i686: '336d1b5cd1b6d0abfafd0b9c12e925ccd3e239acca9c55b09835fe9ada917736',
     x86_64: 'e6023a153a255916cda39d0598c8cfa7b38345b6c69d5bf61babd54fec66f624',
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
