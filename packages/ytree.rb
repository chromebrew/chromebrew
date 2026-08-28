require 'package'

class Ytree < Package
  description 'A (curses-based) file manager similar to DOS Xtree(tm).'
  homepage 'https://www.han.de/~werner/ytree.html'
  version '2.13'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.han.de/~werner/ytree-#{version}.tar.gz"
  source_sha256 'caeeeac334dac83921bd8b657ad2d4cf234c15da4ffc7d15dad0bda99e52f197'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a5dcf60f6f914b13070ef6dbce0cb8e9be413a081e63fbe4e0c766d57b1dc8b',
     armv7l: '2a5dcf60f6f914b13070ef6dbce0cb8e9be413a081e63fbe4e0c766d57b1dc8b',
       i686: '2469c699907329fcdc70e8dd0a173a535864f426291d03aa7782cb8a143e365b',
     x86_64: '50f63a48b9f4539dc7650652b710d760355a17a328aa63f1667fadbab18ba831'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'readline' => :executable

  def self.patch
    system "sed -i 's,/usr,#{CREW_DEST_PREFIX},' Makefile"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    system "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw' make install"
  end
end
