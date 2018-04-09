require 'package'

class Libdnet < Package
  description 'libdnet provides a simplified, portable interface to several low-level networking routines.'
  homepage 'https://github.com/dugsong/libdnet'
  version '1.12'
  source_url 'https://github.com/dugsong/libdnet/archive/libdnet-1.12.tar.gz'
  source_sha256 'b6360659c93fa2e3cde9e0a1fc9c07bc4111f3448c5de856e095eb98315dd424'

  binary_url ({
  })
  binary_sha256 ({
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
