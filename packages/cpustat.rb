require 'package'

class Cpustat < Package
  description 'cpustat periodically dumps out the current CPU utilisation statistics of running processes.'
  homepage 'https://kernel.ubuntu.com/~cking/cpustat/'
  version '0.02.09'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/cpustat/cpustat-0.02.09.tar.xz'
  source_sha256 'fe48369cf031ecf5edd77f585c66b66d3c6e71a0933230502e1a665fcc86aa8b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.09-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.09-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.09-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.09-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '14b4aa6110904b31c0259f3bc6aeba5efeca97b8c8d95a6342fd1bbf2b81f426',
     armv7l: '14b4aa6110904b31c0259f3bc6aeba5efeca97b8c8d95a6342fd1bbf2b81f426',
       i686: '7eab479cc88afe2a1336f5a0c091bcf44751a561c911f77fce86e3b29abe2e59',
     x86_64: 'aa9a721eaa7cd8c54306e744cf40d40db278742a9542a69956b68d3c7f42fdae',
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
