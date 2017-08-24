require 'package'

class Redis < Package
  description 'Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.'
  homepage 'https://redis.io/'
  version '4.0.1'
  source_url 'http://download.redis.io/releases/redis-4.0.1.tar.gz'
  source_sha256 '2049cd6ae9167f258705081a6ef23bb80b7eff9ff3d0d7481e89510f27457591'

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
