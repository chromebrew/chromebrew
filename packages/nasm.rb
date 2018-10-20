require 'package'

class Nasm < Package
  description 'The Netwide Assembler'
  homepage 'https://www.nasm.us/'
  version '2.14rc16'
  source_url 'https://www.nasm.us/pub/nasm/releasebuilds/2.14rc16/nasm-2.14rc16.tar.xz'
  source_sha256 '084482a7708c46ef6ab480488d29092cf9d4d5b9e8a5d0ba58d69eee1758f358'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.14rc16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.14rc16-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.14rc16-chromeos-x86_64.tar.xz',
    i686: 'file:///home/chronos/user/chromebrew/release/i686/nasm-2.14rc16-chromeos-i686.tar.xz'
  })
  binary_sha256 ({
    aarch64: '167d71028afc02c296a27fb8a145f873986da262cc1e954dac80644fd57e4fc8',
     armv7l: '167d71028afc02c296a27fb8a145f873986da262cc1e954dac80644fd57e4fc8',
     x86_64: '7aed39d25a05f43613950f27d0033dfa890804c9398ab7549c70ba951c2355d1',
       i686: '87728c542fe6322b64bcadb9aaea25779c53d6059c8062d40d770d0593daf2c0',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
