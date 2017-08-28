require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.14.0'
  source_url 'https://dist.libuv.org/dist/v1.14.0/libuv-v1.14.0.tar.gz'
  source_sha256 '7267f1564fc6bd84e1721ad7e3cdd7b5da06faab9fa09522f33589dc08d3edf9'

  binary_url ({
  })
  binary_sha256 ({
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
