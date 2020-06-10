require 'package'

class Bacula < Package
  description 'Bacula is a set of computer programs that permits the system administrator to manage backup, recovery, and verification of computer data across a network of computers of different kinds.'
  homepage 'https://www.bacula.org/'
  version '9.4.2'
  compatibility 'all'
  source_url 'https://www.bacula.org/download/7471/bacula-9.4.2.tar.gz'
  source_sha256 'a40d04d2c48135972cecb6578405e835c4b9d798c0950017de0fad40ca94e8a0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bacula-9.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bacula-9.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bacula-9.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bacula-9.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1a0a0c032e40a648e9e9492aa428e9c674b1baa7ee76f5254f070f385be31263',
     armv7l: '1a0a0c032e40a648e9e9492aa428e9c674b1baa7ee76f5254f070f385be31263',
       i686: 'adf9481e8804d07ae4dfa80dab24bd6646feda2465dbf773fd21fa30a75d46bb',
     x86_64: '1fccff1952a812660fa134102e8afe8b3faae7d61aa12f587dca9d00d14a4b53',
  })

  depends_on 'lzo'
  depends_on 'percona_server'
  depends_on 'tcpwrappers'
  depends_on 'sommelier'

  def self.patch
    system 'filefix'
  end

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--sbindir=#{CREW_PREFIX}/bin",
           "--datarootdir=#{CREW_PREFIX}",
           "--mandir=#{CREW_PREFIX}/share/man",
           "--includedir=#{CREW_PREFIX}/include",
           "--sysconfdir=#{CREW_PREFIX}/share/bacula/bin",
           "--with-pid-dir=#{CREW_PREFIX}/share/bacula/bin/working",
           "--with-subsys-dir=#{CREW_PREFIX}/share/bacula/bin/working",
           "--with-working-dir=#{CREW_PREFIX}/share/bacula/bin/working",
           "--with-dump-email=#{USER}@localhost",
           "--with-job-email=#{USER}@localhost",
           '--with-smtp-host=localhost',
           '--with-tcp-wrappers',
           '--enable-smartalloc',
           '--with-mysql',
           '--with-x'
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' Makefile" 
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
