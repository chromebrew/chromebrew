require 'buildsystems/autotools'

class Redis < Autotools
  description 'Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.'
  homepage 'https://redis.io/'
  version '8.10.0'
  license 'BSD'
  compatibility 'all'
  source_url "http://download.redis.io/releases/redis-#{version}.tar.gz"
  source_sha256 'f1baa4b28befd417aa6577ebeedde9e9fc7814cfcc299b2a6d2fd99ef7420a6c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '42719b23596a9340ae1e87321b91ec810fd6a3f5c69b540036674ce56c78d0e8',
     armv7l: '42719b23596a9340ae1e87321b91ec810fd6a3f5c69b540036674ce56c78d0e8',
       i686: 'c0b2c01f64fe02f922488d766047de9d40b8dd0b8409c4d840a7f52d6886ce8a',
     x86_64: 'a52137729d4194dab6b1a164f9e3a984a121a44c4812c548d2e8e921329f9edd'
  })

  depends_on 'tcl' => :build

  autotools_skip_configure

  def self.check
    system './runtest'
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      To start the redis server: redis-server --daemonize yes
      To connect to the server: redis-cli
    EOM
  end
end
