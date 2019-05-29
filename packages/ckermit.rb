require 'package'

class Ckermit < Package
  description 'C-Kermit is a combined serial and network communication software package offering a consistent, medium-independent, secure cross-platform approach to connection establishment, terminal sessions, file transfer, character-set translation, and automation of communication tasks.'
  homepage 'http://www.kermitproject.org/ck90.html'
  version '211'
  source_url 'https://fossies.org/linux/privat/old/cku211.tar.gz'
  source_sha256 '0503518ef8f225d06749f7923ae84521bc358daf353222c75c009cd040dc5e26'

  binary_url ({
    aarch64: '',
     armv7l: '',
       i686: '',
     x86_64: '',
  })
  binary_sha256 ({
    aarch64: '',
     armv7l: '',
       i686: '',
     x86_64: '',
  })

  depends_on 'ncurses'

  def self.build
    system 'make KFLAGS="-DCK_NCURSES -I/usr/local/include/ncurses" LNKFLAGS="-lresolv -lcrypt" linux'

  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
