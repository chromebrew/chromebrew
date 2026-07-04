require 'buildsystems/autotools'

class Memcached < Autotools
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.6.43'
  license 'BSD'
  compatibility 'all'
  source_url "https://memcached.org/files/memcached-#{version}.tar.gz"
  source_sha256 '8042ee26e004efa0db41ca4a7c713f759c3280c2f8bee438579f13de1e509435'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c43c4b03228bf00a22d747b861dcd7defe3ee431c1ae32af0b1c9b1d631aea7',
     armv7l: '8c43c4b03228bf00a22d747b861dcd7defe3ee431c1ae32af0b1c9b1d631aea7',
       i686: '4ce88154313636ae30bc5ccbaef3cbef877c6e2a03abb3846e751141f0ac5157',
     x86_64: 'ea6309433b14c016b7395b0d66e13e69bbc9e1919b09c73e8dc028e6a8dde9de'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libevent' => :executable
end
