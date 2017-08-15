require 'package'

class Smemstat < Package
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'http://kernel.ubuntu.com/~cking/smemstat/'
  version '0.01.16'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/smemstat/smemstat-0.01.16.tar.gz'
  source_sha256 '232e220574a6d7a8d75dec3aae79ae26b2102cd62ade9d1b2a78a5baa2d1c392'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/smemstat-0.01.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/smemstat-0.01.16-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/smemstat-0.01.16-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/smemstat-0.01.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '64b244e490ed04dcb16a2c5797311240a54310788f3a269311b31490d80a7e7f',
     armv7l: '64b244e490ed04dcb16a2c5797311240a54310788f3a269311b31490d80a7e7f',
       i686: '668a55d432813b8a150252f897b2c004778e5d7dbd316b4b7b6d9e206db720c5',
     x86_64: '34ce6004d5c2021c956999f7c24c07bc711cbb77532b2c38282bf5f19187dd38',
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
