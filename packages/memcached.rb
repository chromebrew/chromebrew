require 'package'

class Memcached < Package
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.5.16'
  source_url 'https://memcached.org/files/memcached-1.5.16.tar.gz'
  source_sha256 '45a22c890dc1edb27db567fb4c9c25b91bfd578477c08c5fb10dca93cc62cc5a'

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
