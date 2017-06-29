require 'package'

class Cpustat < Package
  description 'cpustat periodically dumps out the current CPU utilisation statistics of running processes.'
  homepage 'http://kernel.ubuntu.com/~cking/cpustat/'
  version '0.02.01'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/cpustat/cpustat-0.02.01.tar.gz'
  source_sha256 '5a4e81b68f89057fc5a6e7ec4ba2c21ae70035193ea8493c2b0eb4b0815a27bf'

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
