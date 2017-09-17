require 'package'

class Smemstat < Package
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'http://kernel.ubuntu.com/~cking/smemstat/'
  version '0.01.17'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/smemstat/smemstat-0.01.17.tar.gz'
  source_sha256 '350aae5e604d49e471bd4ab11a5e2c27b7056b848685ffeb049521647e767124'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.01.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.01.17-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.01.17-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.01.17-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9978add15efd257d0915cc2982d0231efd92cdfcfd4642cbb5859aa48ba83209',
     armv7l: '9978add15efd257d0915cc2982d0231efd92cdfcfd4642cbb5859aa48ba83209',
       i686: '3e2b14f61e0ca5a43add0b6bfcc0a42f830f3b7e25ec1ff947e85b99ac64793e',
     x86_64: '4f42dce4e4cff905bedfd9483864104de13ec3fccc4490d4b24ecf0cae421757',
  })

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
