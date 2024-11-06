require 'package'

class Ytree < Package
  description 'A (curses-based) file manager similar to DOS Xtree(tm).'
  homepage 'https://www.han.de/~werner/ytree.html'
  version '2.07'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.han.de/~werner/ytree-2.07.tar.gz'
  source_sha256 '636f4adb6fefea3b29669f700faf94e7a40ec7f033a42c8b31a0bfe41effcceb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1dd103252673e85e3d1186d7a32962e7091f66872959d272712909d4015413b5',
     armv7l: '1dd103252673e85e3d1186d7a32962e7091f66872959d272712909d4015413b5',
       i686: 'f98ff9cfb6d15da7c9e6b3d23284d4b004c6ccb641c7987b0949db63542135c3',
     x86_64: '5a0512fb0c099e852694cb287f842cb23c5389307ae899f331eb3370b38ea127'
  })

  depends_on 'ncurses'

  def self.patch
    system "sed -i 's,/usr,#{CREW_DEST_PREFIX},' Makefile"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    system "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw' make install"
  end
end
