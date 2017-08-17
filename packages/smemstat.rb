require 'package'

class Smemstat < Package
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'http://kernel.ubuntu.com/~cking/smemstat/'
  version '0.01.17'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/smemstat/smemstat-0.01.17.tar.gz'
  source_sha256 '350aae5e604d49e471bd4ab11a5e2c27b7056b848685ffeb049521647e767124'

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
