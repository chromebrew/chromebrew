require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.14.0'
  source_url 'https://dist.libuv.org/dist/v1.14.0/libuv-v1.14.0.tar.gz'
  source_sha256 '7267f1564fc6bd84e1721ad7e3cdd7b5da06faab9fa09522f33589dc08d3edf9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.14.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.14.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.14.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.14.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '170083ce6a5327b399dd4a9d478e0d60730cd4025933be1304bf6a93122b51d1',
     armv7l: '170083ce6a5327b399dd4a9d478e0d60730cd4025933be1304bf6a93122b51d1',
       i686: '2d7d9d18d8f056592f84fad99978eefd9d4ed723f975b2f8f60de62800c50fac',
     x86_64: '88801cf1d298dc695e956d29a059516db578ffe26ecb607128f381cdcf7a7b62',
  })

  depends_on 'automake'
  depends_on 'glibc'
  depends_on 'libtool'

  def self.build
    system './autogen.sh'
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
