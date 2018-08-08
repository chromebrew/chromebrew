require 'package'

class Aide < Package
  description 'Advanced Intrusion Detection Environment'
  homepage 'http://aide.sourceforge.net/'
  version '0.16'
  source_url 'http://downloads.sourceforge.net/project/aide/aide/0.16/aide-0.16.tar.gz'
  source_sha256 'a81c53a131c4fd130b169b3a26ac35386a2f6e1e014f12807524cc273ed97345'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libgcrypt'
  depends_on 'pcre'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--with-gcrypt'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "sed -i '22d' doc/aide.conf"
    system "sed -i '24d' doc/aide.conf"
    system "sed -i '24i@@define TOPDIR #{CREW_PREFIX}/etc' doc/aide.conf"
    system "install -Dm644 doc/aide.conf #{CREW_DEST_PREFIX}/etc/aide.conf"
    system "install -Dm644 doc/aide.conf.5 #{CREW_DEST_PREFIX}/man/man5/aide.conf.5"
    system "touch aide.db"
    system "install -Dm644 aide.db #{CREW_DEST_PREFIX}/etc/doc/aide.db"
  end

  def self.postinstall
    puts
    puts "The configuration file is located at #{CREW_PREFIX}/etc/aide.conf".lightblue
    puts
    puts "To initialize the database, execute the following:".lightblue
    puts "mkdir #{CREW_PREFIX}/etc/src".lightblue
    puts "cd #{CREW_PREFIX}/etc/doc".lightblue
    puts "aide -i".lightblue
    puts "mv aide.db.new aide.db".lightblue
    puts
  end
end
