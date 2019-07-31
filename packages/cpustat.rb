require 'package'

class Cpustat < Package
  description 'cpustat periodically dumps out the current CPU utilisation statistics of running processes.'
  homepage 'https://kernel.ubuntu.com/~cking/cpustat/'
  version '0.02.09'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/cpustat/cpustat-0.02.09.tar.xz'
  source_sha256 'fe48369cf031ecf5edd77f585c66b66d3c6e71a0933230502e1a665fcc86aa8b'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i 's,sbin,bin,' Makefile"
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s,$, -I#{CREW_PREFIX}/include/ncurses,' Makefile"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
