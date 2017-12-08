require 'package'

class Redis < Package
  description 'Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.'
  homepage 'https://redis.io/'
  version '4.0.6'
  source_url 'http://download.redis.io/releases/redis-4.0.6.tar.gz'
  source_sha256 '769b5d69ec237c3e0481a262ff5306ce30db9b5c8ceb14d1023491ca7be5f6fa'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'tcl' => :build

  def self.build
    system "CC='gcc' make"
    system "./runtest"
  end

  def self.install
    system "make", "PREFIX=#{CREW_DEST_PREFIX}", "install"
  end

  def self.postinstall
    puts
    puts "To start the redis server: redis-server --daemonize yes".lightblue
    puts "To connect to the server: redis-cli".lightblue
    puts
  end
end
