require 'package'

class Memcached < Package
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.5.4'
  source_url 'https://www.memcached.org/files/memcached-1.5.4.tar.gz'
  source_sha256 'e0c3cfa89fa4c2ffd8aa45df7825c6d1a2423ac89ab1a7c4f42bb9803f7403d4'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libevent'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
