require 'package'

class Nmon < Package
  description "nmon is short for Nigel's performance MONitor for Linux"
  homepage 'http://nmon.sourceforge.net/pmwiki.php'
  version '16g'
  license 'GPL-3'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/nmon/lmon16g.c'
  source_sha256 'da82dd693b503b062854dfe7dbb5d36b347872ab44a4aa05b97e9d577747f688'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nmon/16g_armv7l/nmon-16g-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nmon/16g_armv7l/nmon-16g-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nmon/16g_i686/nmon-16g-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nmon/16g_x86_64/nmon-16g-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'bcb216dff6287ea5bfe77ab99e0f299739be39c8e53d8887ad304f68faf8363e',
     armv7l: 'bcb216dff6287ea5bfe77ab99e0f299739be39c8e53d8887ad304f68faf8363e',
       i686: 'ae03d1026a0178732a0bdc024b746c0839d028af13efbabc6aa42c1c58a1d698',
     x86_64: 'ee701f555a32e7161fee50662f34151c7378f65751393a2e9ab974af3da97d93'
  })

  depends_on 'ncurses'

  def self.build
    system 'curl -#LO http://downloads.sourceforge.net/project/nmon/lmon16g.c'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('lmon16g.c')) == 'da82dd693b503b062854dfe7dbb5d36b347872ab44a4aa05b97e9d577747f688'
    system "sed -i 's,<ncurses.h>,<#{CREW_PREFIX}/include/ncurses/ncurses.h>,' lmon16g.c"
    system 'cc -o nmon lmon16g.c -g -O3 -Wall -D JFS -D GETUSER -D LARGEMEM -lncurses -lm -g -D POWER'
  end

  def self.install
    system "install -Dm755 nmon #{CREW_DEST_PREFIX}/bin/nmon"
  end
end
