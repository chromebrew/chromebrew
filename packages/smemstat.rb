require 'package'

class Smemstat < Package
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'http://kernel.ubuntu.com/~cking/smemstat/'
  version '0.02.07'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/smemstat/smemstat-0.02.07.tar.xz'
  source_sha256 'acc17fdd6da92571e73a58bf1512b398cb307b80f46dc196cbb8102e7fb02526'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
