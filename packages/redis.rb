require 'package'

class Redis < Package
  description 'Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.'
  homepage 'https://redis.io/'
  version '4.0.2'
  source_url 'http://download.redis.io/releases/redis-4.0.2.tar.gz'
  source_sha256 'b1a0915dbc91b979d06df1977fe594c3fa9b189f1f3d38743a2948c9f7634813'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a4f24f53f082024ce3e6b7e67c5cc345a8839f3beefe6dee29a544e29df12c8f',
     armv7l: 'a4f24f53f082024ce3e6b7e67c5cc345a8839f3beefe6dee29a544e29df12c8f',
       i686: '6d0a44c6cc3d28126d7ef5fe2d1530d40b29ddb0922f34b8a61b9ba38036d9e5',
     x86_64: 'b67ed9e6102db702dbf1d1b9b31bcbe377a4f6b43643ee5a1c98cc656909a028',
  })

  depends_on 'buildessential'

  def self.build
    system "CC='gcc' make"
  end

  def self.install
    system "make", "PREFIX=#{CREW_DEST_PREFIX}", "install"
    puts "-----------------"
    puts "Installation success!"
    puts "To start the redis server: redis-server --daemonize yes"
    puts "To connect to the server: redis-cli"
  end
end
