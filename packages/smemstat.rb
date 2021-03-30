require 'package'

class Smemstat < Package
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'https://kernel.ubuntu.com/~cking/smemstat/'
  version '0.02.07-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/smemstat/smemstat-0.02.07.tar.xz'
  source_sha256 'acc17fdd6da92571e73a58bf1512b398cb307b80f46dc196cbb8102e7fb02526'

  depends_on 'ncursesw'

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncursesw/' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
