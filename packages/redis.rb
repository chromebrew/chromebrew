require 'package'

class Redis < Package
  description 'Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.'
  homepage 'https://redis.io/'
  version '4.0.6'
  compatibility 'all'
  source_url 'http://download.redis.io/releases/redis-4.0.6.tar.gz'
  source_sha256 '769b5d69ec237c3e0481a262ff5306ce30db9b5c8ceb14d1023491ca7be5f6fa'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '42719b23596a9340ae1e87321b91ec810fd6a3f5c69b540036674ce56c78d0e8',
     armv7l: '42719b23596a9340ae1e87321b91ec810fd6a3f5c69b540036674ce56c78d0e8',
       i686: 'c0b2c01f64fe02f922488d766047de9d40b8dd0b8409c4d840a7f52d6886ce8a',
     x86_64: 'a52137729d4194dab6b1a164f9e3a984a121a44c4812c548d2e8e921329f9edd',
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
