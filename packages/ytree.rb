require 'package'

class Ytree < Package
  description 'A (curses-based) file manager similar to DOS Xtree(tm).'
  homepage 'https://www.han.de/~werner/ytree.html'
  version '2.14'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.han.de/~werner/ytree-#{version}.tar.gz"
  source_sha256 '1dac8ce79a075c17de159383c2056961f51bf1160ade3661e7a831755bec0f93'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1956a80e78e8a6e23dd094b5ac94f0a053e29e9e1ecd14eb1adf668ea872c314',
     armv7l: '1956a80e78e8a6e23dd094b5ac94f0a053e29e9e1ecd14eb1adf668ea872c314',
       i686: 'cafcb529c8fff90c32e079add4459bfcf35fc807dc8fc84c4925d2ffece90588',
     x86_64: 'ad624aa08df548d070e6bbf5cc2c9b818f63cc469f3327bd0ccfd1b79cc962e3'
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
