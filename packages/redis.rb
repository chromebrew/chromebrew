require 'package'

class Redis < Package
  description 'Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.'
  homepage 'https://redis.io/'
  version '4.0.1'
  source_url 'http://download.redis.io/releases/redis-4.0.1.tar.gz'
  source_sha256 '2049cd6ae9167f258705081a6ef23bb80b7eff9ff3d0d7481e89510f27457591'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/redis-4.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bbfe8f3f61405a5afadfd724e969db4ad37c562e764764377316b881d83e5011',
     armv7l: 'bbfe8f3f61405a5afadfd724e969db4ad37c562e764764377316b881d83e5011',
       i686: '995ef2a996369cec2cfad0f60bcb42ab36a38d88ed207d10bcf4e67ea93a9d3d',
     x86_64: '7d8affbafbe7707ca4ee471c0057ececda07ab0fa6136cea3adafbef3c9f820f',
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
