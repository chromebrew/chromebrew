require 'package'

class Cpustat < Package
  description 'cpustat periodically dumps out the current CPU utilisation statistics of running processes.'
  homepage 'https://kernel.ubuntu.com/~cking/cpustat/'
  version '0.02.10-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/cpustat/cpustat-0.02.10.tar.xz'
  source_sha256 'ea9ab5a970ec657496c0127e3e5d58d49ce0fe07e750b4aafcfeb4896ccd74e9'

  def self.build
    system "sed -i 's,sbin,bin,' Makefile"
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s,$, -I#{CREW_PREFIX}/include/ncursesw,' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
