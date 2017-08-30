require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'http://www.ijg.org/'
  version '9.1-1'
  source_url 'http://www.ijg.org/files/jpegsrc.v9a.tar.gz'
  source_sha256 '3a753ea48d917945dd54a2d97de388aa06ca2eb1066cbfdc6652036349fe05a7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '813fe8083f6f03909543b6f2feaf9e3cb0dc6b5704484cfbc56657630f45d227',
     armv7l: '813fe8083f6f03909543b6f2feaf9e3cb0dc6b5704484cfbc56657630f45d227',
       i686: '98b05d6ed65d1ed43ba8940db05275d819dc5574f85044d321b343d1c2a3e7b0',
     x86_64: 'bd6832fa0b0d2ad611227c55e58927b7f88ecf69e4ff0d14d09699112a786a29',
  })

  def self.build
    system "./configure --includedir=/usr/local/include CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
