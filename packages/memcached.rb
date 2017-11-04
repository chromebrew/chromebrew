require 'package'

class Memcached < Package
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.5.3'
  source_url 'https://memcached.org/files/memcached-1.5.3.tar.gz'
  source_sha256 '258cc3ddb7613685465acfd0215f827220a3bbdd167fd2c080632105b2d2f3ce'

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
