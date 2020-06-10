require 'package'

class Libevent < Package
  description 'The libevent API provides a mechanism to execute a callback function when a specific event occurs on a file descriptor or after a timeout has been reached.'
  homepage 'http://libevent.org/'
  version '2.1.8-0'
  compatibility 'all'
  source_url 'https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz'
  source_sha256 '965cc5a8bb46ce4199a47e9b2c9e1cae3b137e8356ffdad6d94d3b9069b71dc2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libevent-2.1.8-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libevent-2.1.8-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libevent-2.1.8-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libevent-2.1.8-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7e6f34d7a5b630d11a28f1db646f4b1a25f4a52a16ca218de1ea888c8902fb3c',
     armv7l: '7e6f34d7a5b630d11a28f1db646f4b1a25f4a52a16ca218de1ea888c8902fb3c',
       i686: '766487b0654c830515d6e8759bc62ae7844b648221efa05d5a83ba2b2516a36f',
     x86_64: '414ce2cd93f54f9a904f6ce59f4111d85cc1f126ea059750e6fe7df1fbe9eb1d',
  })

  depends_on 'openssl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
