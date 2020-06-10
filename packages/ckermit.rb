require 'package'

class Ckermit < Package
  description 'C-Kermit is a combined serial and network communication software package.'
  homepage 'http://www.kermitproject.org/ck90.html'
  version '8.0.211-1'
  compatibility 'all'
  source_url 'https://fossies.org/linux/privat/old/cku211.tar.gz'
  source_sha256 '0503518ef8f225d06749f7923ae84521bc358daf353222c75c009cd040dc5e26'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ckermit-8.0.211-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ckermit-8.0.211-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ckermit-8.0.211-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ckermit-8.0.211-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5779bf0c226ec6ef42ad40c3e4a739524eb2a5d6cf4949404fc536529e3932d6',
     armv7l: '5779bf0c226ec6ef42ad40c3e4a739524eb2a5d6cf4949404fc536529e3932d6',
       i686: 'f2aadf15b263d81a760e48a7fc23f674a4833bb1af387bfce57396f772efdc84',
     x86_64: '4740c149d172a854b916912da26d7afdaf61a91a20642fc8aa568cf734cde194',
  })

  depends_on 'ncurses'

  def self.build
    system "make KFLAGS='-DCK_NCURSES -I#{CREW_PREFIX}/include/ncurses' LNKFLAGS='-lresolv -lcrypt' linux"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man1"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "manroot=#{CREW_DEST_PREFIX}/share", 'install'
    system "sed -i \"s:#{CREW_DEST_PREFIX}:#{CREW_PREFIX}:g\" #{CREW_DEST_PREFIX}/bin/ckermit.ini"
    system "ln -sf #{CREW_PREFIX}/bin/kermit #{CREW_DEST_PREFIX}/bin/kermit-sshsub"
  end
end
