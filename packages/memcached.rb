require 'package'

class Memcached < Package
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.5.0'
  source_url 'https://memcached.org/files/memcached-1.5.0.tar.gz'
  source_sha256 'c001f812024bb461b5e4d7d0506daab63dff9614eea26f46536c3b7e1e601c32'

  depends_on 'libevent'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
