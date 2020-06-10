require 'package'

class Aide < Package
  description 'Advanced Intrusion Detection Environment'
  homepage 'http://aide.sourceforge.net/'
  version '0.15.1'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/aide/aide/0.15.1/aide-0.15.1.tar.gz'
  source_sha256 '303e5c186257df8c86e418193199f4ea2183fc37d3d4a9098a614f61346059ef'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aide-0.15.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aide-0.15.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aide-0.15.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aide-0.15.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '805f42e0824ab40aa56a0b304636b7eac9da43832a2b20760e49a348a35f0a26',
     armv7l: '805f42e0824ab40aa56a0b304636b7eac9da43832a2b20760e49a348a35f0a26',
       i686: '90ffe18ff6970dd02e3625943ff68ccf4f3a53b795d781a4e1a0b6d449172401',
     x86_64: '74b87dbc5ca9a9bfa16420b136afba5fa513da3c75b13993bb11051d14c2a5f6',
  })

  depends_on 'libgcrypt'
  depends_on 'pcre'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--disable-static',
           '--with-gcrypt',
           '--without-zlib'
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
