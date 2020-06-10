require 'package'

class Libmicrohttpd < Package
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '0.9.58'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libmicrohttpd/libmicrohttpd-0.9.58.tar.gz'
  source_sha256 '7a11e1376c62ff95bd6d2dfe6799d57ac7cdbcb32f70bfbd5e47c71f373e01f3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmicrohttpd-0.9.58-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmicrohttpd-0.9.58-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmicrohttpd-0.9.58-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmicrohttpd-0.9.58-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '861604f225237f0ab46185d0b71fb8e405efe376c1c8014dc15ad1491ab76e8f',
     armv7l: '861604f225237f0ab46185d0b71fb8e405efe376c1c8014dc15ad1491ab76e8f',
       i686: '056291de57c0e46c8632cc4cc9f46d15aa4aab580777894694923ac8b2374ebe',
     x86_64: 'aa41e8d0577c54de70b7f830be5780d5b9f5d92ccafca54570d9a97a9b7fda15',
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
