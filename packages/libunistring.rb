require 'package'

class Libunistring < Package
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '0.9.9'
  source_url 'https://ftpmirror.gnu.org/libunistring/libunistring-0.9.9.tar.xz'
  source_sha256 'a4d993ecfce16cf503ff7579f5da64619cee66226fb3b998dafb706190d9a833'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '570ba012dd7e01f7d4a7e859e4afafc61a607ae7762c32f1bfcdd63f9e04bb18',
     armv7l: '570ba012dd7e01f7d4a7e859e4afafc61a607ae7762c32f1bfcdd63f9e04bb18',
       i686: 'd55df8d5c90d2ea1cf9ee75059950859c0afbc134680bd77c11022aec848ffc8',
     x86_64: '5f0dc6bafb63fd29c678d320c4a211675f6f1812ac8c8d8ef0e1fb950bdbc02f',
  })

  depends_on 'glibc'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--enable-shared'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
