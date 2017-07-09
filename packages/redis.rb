require 'package'

class Redis < Package
  description 'Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.'
  homepage 'https://redis.io/'
  version '3.0.6'
  source_url 'http://download.redis.io/releases/redis-3.0.6.tar.gz'
  source_sha256 '6f1e1523194558480c3782d84d88c2decf08a8e4b930c56d4df038e565b75624'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/redis-3.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/redis-3.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/redis-3.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/redis-3.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8e4d0c3009a3e4ffaee4727c76a6222688545ed73545514d1da37bf41bd93cef',
     armv7l: '8e4d0c3009a3e4ffaee4727c76a6222688545ed73545514d1da37bf41bd93cef',
       i686: '713b5557790d7b7ebbe914cfc7455b662a6da87a2151cb5c760999dd88580938',
     x86_64: 'b23c3c35bc4f52b3af158f0dcdd7db136d9cfcca6e9cb0366fbe8ce05dfdfbe8',
  })

  depends_on 'buildessential'

  def self.build
    system "CC='gcc' make"
  end

  def self.install
    system "make", "PREFIX=#{CREW_DEST_DIR}/usr/local", "install"
    puts "-----------------"
    puts "Installation success!"
    puts "To start the redis server: redis-server --daemonize yes"
    puts "To connect to the server: redis-cli"
  end
end
