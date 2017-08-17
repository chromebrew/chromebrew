require 'package'

class Cpustat < Package
  description 'cpustat periodically dumps out the current CPU utilisation statistics of running processes.'
  homepage 'http://kernel.ubuntu.com/~cking/cpustat/'
  version '0.02.03'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/cpustat/cpustat-0.02.03.tar.gz'
  source_sha256 '8e48cbd6927b9060a59cd278bb855f6fcdb773ff5ff919a1f75c086c94b4c1d0'

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
