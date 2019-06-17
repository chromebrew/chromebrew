require 'package'

class Smemstat < Package
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'http://kernel.ubuntu.com/~cking/smemstat/'
  version '0.02.03'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/smemstat/smemstat-0.02.03.tar.xz'
  source_sha256 'a14b3ab5c92b098f5e270e54ab38d1119ff6f9121251a9690b8fd83316370013'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.03-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.03-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.03-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.03-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c6c10ba34a6b88683f211ed488ccc6ad29532eb1af85cf5b2aa732f783835f9f',
     armv7l: 'c6c10ba34a6b88683f211ed488ccc6ad29532eb1af85cf5b2aa732f783835f9f',
       i686: 'b2c42bbbb40ba916e2d249f4d8eb90e9286440346dca42760143ef0c0bf7023e',
     x86_64: '6a2319b55912cb3d7fb3d26a5a49844b74cfc22751d0d07577dde455fc4c4d62',
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
