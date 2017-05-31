require 'package'

class Cpustat < Package
  description 'cpustat periodically dumps out the current CPU utilisation statistics of running processes.'
  homepage 'http://kernel.ubuntu.com/~cking/cpustat/'
  version '0.02.01'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/cpustat/cpustat-0.02.01.tar.gz'
  source_sha1 '0eca37a1c6e1282b05be51fc2dd1dac72875112d'

  depends_on "ncurses"

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
