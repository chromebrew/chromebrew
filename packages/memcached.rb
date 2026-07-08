require 'buildsystems/autotools'

class Memcached < Autotools
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.6.44'
  license 'BSD'
  compatibility 'all'
  source_url "https://memcached.org/files/memcached-#{version}.tar.gz"
  source_sha256 'c41a9d2713dfc56b5f4fa0075b2751973ea840c1f1ab8d6bfed08a1848938368'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44e9a16270d5bbe1bcc2a5a174dd4608bcced50f4461584b356861bb5edaeb25',
     armv7l: '44e9a16270d5bbe1bcc2a5a174dd4608bcced50f4461584b356861bb5edaeb25',
       i686: 'b5e5e95c8ec657e9859ed2938be6763e0e52776d44109383137db3feab2ee36b',
     x86_64: 'd82f57b684605b06188b7fd80c296ff7fec3ef0d1864c490fb9b14b11337c37d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libevent' => :executable
end
