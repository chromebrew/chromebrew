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
    aarch64: '881517db6cdb13a4d4dfedde37407e2a30b5b988f9ad0af8e3408c49fc971e02',
     armv7l: '881517db6cdb13a4d4dfedde37407e2a30b5b988f9ad0af8e3408c49fc971e02',
       i686: 'ac2ca592ebdd73527ea32c5abb8bfecf4f4325e98b92f9fab04b6060b08e0e78',
     x86_64: '31e7f5b88e40310c160be3499d47d7e2c30e179fd0557b49f38c09b0c41c6a80'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libevent' => :executable
end
