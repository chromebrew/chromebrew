require 'package'

class Cpustat < Package
  description 'cpustat periodically dumps out the current CPU utilisation statistics of running processes.'
  homepage 'https://kernel.ubuntu.com/~cking/cpustat/'
  version '0.02.10'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/cpustat/cpustat-0.02.10.tar.xz'
  source_sha256 'ea9ab5a970ec657496c0127e3e5d58d49ce0fe07e750b4aafcfeb4896ccd74e9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd8a55c174fee28fc12a5a153836696fdfc7320f5fbc106095e0d18faccc7c58e',
     armv7l: 'd8a55c174fee28fc12a5a153836696fdfc7320f5fbc106095e0d18faccc7c58e',
       i686: '8e215c1064acc4bc8329f801d79aa96b7d8537596e6b91c12037c5782f5b3454',
     x86_64: '8e96b86281a64fe06adc42c18a8507f0e52ffba4368cd3acb96b4f428ad0bb0d',
  })

  def self.build
    system "sed -i 's,sbin,bin,' Makefile"
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s,$, -I#{CREW_PREFIX}/include/ncurses,' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
