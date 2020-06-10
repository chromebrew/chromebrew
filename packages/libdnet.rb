require 'package'

class Libdnet < Package
  description 'libdnet provides a simplified, portable interface to several low-level networking routines.'
  homepage 'https://github.com/dugsong/libdnet'
  version '1.12'
  compatibility 'all'
  source_url 'https://github.com/dugsong/libdnet/archive/libdnet-1.12.tar.gz'
  source_sha256 'b6360659c93fa2e3cde9e0a1fc9c07bc4111f3448c5de856e095eb98315dd424'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdnet-1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdnet-1.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdnet-1.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdnet-1.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e2ffd93c777b266b5b6933244c2f6675fbfddba8baf8b2f502c71f079016f18d',
     armv7l: 'e2ffd93c777b266b5b6933244c2f6675fbfddba8baf8b2f502c71f079016f18d',
       i686: 'a895eaa5a2d7018708edadb3880e8262423773973bf95074638d7353fb624d27',
     x86_64: '2e0d5a27088afe410e48aeb4266dc6ffa010f97b1e0e0eb897fad10af94c00be',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--sbindir=#{CREW_PREFIX}/bin"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
