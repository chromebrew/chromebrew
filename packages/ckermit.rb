require 'package'

class Ckermit < Package
  description 'C-Kermit is a combined serial and network communication software package.'
  homepage 'http://www.kermitproject.org/ck90.html'
  version '8.0.211'
  source_url 'https://fossies.org/linux/privat/old/cku211.tar.gz'
  source_sha256 '0503518ef8f225d06749f7923ae84521bc358daf353222c75c009cd040dc5e26'

  depends_on 'ncurses'

  def self.build
    system "make KFLAGS='-DCK_NCURSES -I#{CREW_PREFIX}/include/ncurses' LNKFLAGS='-lresolv -lcrypt' linux"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", 'install'
    system "sed -i \"s:#{CREW_DEST_PREFIX}:#{CREW_PREFIX}:g\" #{CREW_DEST_PREFIX}/bin/ckermit.ini"
  end
end
