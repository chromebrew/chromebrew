require 'package'

class Memcached < Package
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.5.1'
  source_url 'https://memcached.org/files/memcached-1.5.1.tar.gz'
  source_sha256 'a87908936b51d1bd3ef10a2347eef5647f003b63407a5d8161fa7928b1cd6b5c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libevent'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
