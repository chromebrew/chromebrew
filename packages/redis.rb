require 'package'

class Redis < Package
  version '3.0.6'
  source_url 'http://download.redis.io/releases/redis-3.0.6.tar.gz'
  source_sha1 '4b1c7b1201984bca8f7f9c6c58862f6928cf0a25'

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
