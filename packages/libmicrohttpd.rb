require 'package'

class Libmicrohttpd < Package
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '0.9.58'
  source_url 'https://ftpmirror.gnu.org/libmicrohttpd/libmicrohttpd-0.9.58.tar.gz'
  source_sha256 '7a11e1376c62ff95bd6d2dfe6799d57ac7cdbcb32f70bfbd5e47c71f373e01f3'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'diffutils' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "gzip -9 #{CREW_DEST_PREFIX}/share/man/man3/libmicrohttpd.3"
  end
end
