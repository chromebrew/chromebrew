require 'package'

class Memcached < Package
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.5.16'
  license 'BSD'
  compatibility 'all'
  source_url 'https://memcached.org/files/memcached-1.5.16.tar.gz'
  source_sha256 '45a22c890dc1edb27db567fb4c9c25b91bfd578477c08c5fb10dca93cc62cc5a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'c80d5865748c2954b08734ed28dc46b5df20c5a222e73d1205f6a2d574d96aff',
     armv7l: 'c80d5865748c2954b08734ed28dc46b5df20c5a222e73d1205f6a2d574d96aff',
       i686: 'f20c7638e5722f37c44b19db3c548a77caa6d8621ca08478e91cbc412af12755',
     x86_64: 'c98b1daab6080fe48960b2731df7dd141abfbe97f571f9602dcc15bf2308f38d'
  })

  depends_on 'libevent'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
