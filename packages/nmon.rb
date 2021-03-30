require 'package'

class Nmon < Package
  description "nmon is short for Nigel's performance MONitor for Linux"
  homepage 'http://nmon.sourceforge.net/pmwiki.php'
  version '16g-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/nmon/lmon16g.c'
  source_sha256 'da82dd693b503b062854dfe7dbb5d36b347872ab44a4aa05b97e9d577747f688'

  depends_on 'ncursesw'

  def self.build
    system 'curl -#LO http://downloads.sourceforge.net/project/nmon/lmon16g.c'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('lmon16g.c') ) == 'da82dd693b503b062854dfe7dbb5d36b347872ab44a4aa05b97e9d577747f688'
    system "sed -i 's,<ncurses.h>,<#{CREW_PREFIX}/include/ncursesw/ncurses.h>,' lmon16g.c"
    system 'cc -o nmon lmon16g.c -g -O3 -Wall -D JFS -D GETUSER -D LARGEMEM -lncurses -lm -g -D POWER'
  end

  def self.install
    system "install -Dm755 nmon #{CREW_DEST_PREFIX}/bin/nmon"
  end
end
