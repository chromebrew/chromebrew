require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.15.0'
  source_url 'https://dist.libuv.org/dist/v1.15.0/libuv-v1.15.0.tar.gz'
  source_sha256 '28b1b334ae79fdbb025c7a4dacf3cb14738f9d336998bc42bbdbe72b8799fe85'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.15.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.15.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.15.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.15.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2bc6b442eb0967f74079d2ea08ed074311324c74aaaaedbcae0205e5c49910d0',
     armv7l: '2bc6b442eb0967f74079d2ea08ed074311324c74aaaaedbcae0205e5c49910d0',
       i686: '24ed01570af74277a056892854c00cb50c03dc4a3ff1f682f2eb4fc2931753cd',
     x86_64: '6f0939d73bc9466817de0a7cbad69fc94d9beed626beb6c549f284332c6590dd',
  })

  depends_on 'automake'
  depends_on 'glibc'
  depends_on 'libtool'

  def self.build
    system './autogen.sh'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
