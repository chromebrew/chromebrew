require 'package'

class Memcached < Package
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.5.2'
  source_url 'https://memcached.org/files/memcached-1.5.2.tar.gz'
  source_sha256 '9ac93113bdb5d037e79c61277386564ac2e5e31d49e594f11e554e4c149b7245'

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
