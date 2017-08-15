require 'package'

class Memcached < Package
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.5.0'
  source_url 'https://memcached.org/files/memcached-1.5.0.tar.gz'
  source_sha256 'c001f812024bb461b5e4d7d0506daab63dff9614eea26f46536c3b7e1e601c32'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/memcached-1.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/memcached-1.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/memcached-1.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/memcached-1.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4d1f4a39ec38931a1d0d119ba44aedc39af6f9626cbabd5a42de7c09c067ef74',
     armv7l: '4d1f4a39ec38931a1d0d119ba44aedc39af6f9626cbabd5a42de7c09c067ef74',
       i686: 'c082e150d5638979f27d6d8e0158fd1b203e252f1114af8ac2408c22ab8dd680',
     x86_64: 'fd9e0e3175e84c12a4e71818477f9b7630582cc343766c70fe5024179a8c92df',
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
