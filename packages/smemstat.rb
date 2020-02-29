require 'package'

class Smemstat < Package
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'http://kernel.ubuntu.com/~cking/smemstat/'
  version '0.02.07'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/smemstat/smemstat-0.02.07.tar.xz'
  source_sha256 'acc17fdd6da92571e73a58bf1512b398cb307b80f46dc196cbb8102e7fb02526'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.07-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.07-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.07-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/smemstat-0.02.07-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '80549cd181fd79bd9c58462ea5e9b87d5f0c0657093a892803ae3db77980b7cb',
     armv7l: '80549cd181fd79bd9c58462ea5e9b87d5f0c0657093a892803ae3db77980b7cb',
       i686: 'b015b51fa07cbaeb7f3f2ae2abcef9a8c425a3f52a3c87c9ad51a4477c5fcf92',
     x86_64: '80884214345553902dd3bef26011b1381c6f16382df34bbd473ee506ddf81e83',
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
