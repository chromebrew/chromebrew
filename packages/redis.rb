require 'package'

class Redis < Package
  description 'Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.'
  homepage 'https://redis.io/'
  version '4.0.2'
  source_url 'http://download.redis.io/releases/redis-4.0.2.tar.gz'
  source_sha256 'b1a0915dbc91b979d06df1977fe594c3fa9b189f1f3d38743a2948c9f7634813'

  binary_url ({
  })
  binary_sha256 ({
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
