require 'package'

class Smemstat < Package
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'http://kernel.ubuntu.com/~cking/smemstat/'
  version '0.01.16'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/smemstat/smemstat-0.01.16.tar.gz'
  source_sha256 '232e220574a6d7a8d75dec3aae79ae26b2102cd62ade9d1b2a78a5baa2d1c392'

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
