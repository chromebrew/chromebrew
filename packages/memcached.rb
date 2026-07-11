require 'buildsystems/autotools'

class Memcached < Autotools
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.6.45'
  license 'BSD'
  compatibility 'all'
  source_url "https://memcached.org/files/memcached-#{version}.tar.gz"
  source_sha256 'd362c64e6d8d5287153501eabf7c85b4a761432fbf53f5d7b085d0bb1653c1dd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc758b91132c375ee48249d17d6c6c261ce5d13887aabb7a69d3465e9aa09f05',
     armv7l: 'fc758b91132c375ee48249d17d6c6c261ce5d13887aabb7a69d3465e9aa09f05',
       i686: 'b1d7eb94924a260bd1dd085e9693ab60f10c8a377211366753e61cf8c8896dda',
     x86_64: '3713d6356361ded0670e4fc797007673ee934ffd2c7a61f52dcc6ee1dfce76f6'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libevent' => :executable
end
