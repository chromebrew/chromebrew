require 'buildsystems/cmake'

class Libuv < CMake
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'https://libuv.org/'
  version '1.52.1'
  license 'BSD, BSD-2, ISC and MIT'
  compatibility 'all'
  source_url "https://dist.libuv.org/dist/v#{version}/libuv-v#{version}.tar.gz"
  source_sha256 '66d511b9e6e334c0e62279eb234fbfb2b3110b1479c09b95b44c7afca8cff9e7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc8ae5c75eb65b7f8b32ddd1b048abae46fab872f192e7ce348c07bc513153b1',
     armv7l: 'fc8ae5c75eb65b7f8b32ddd1b048abae46fab872f192e7ce348c07bc513153b1',
       i686: '66ef1f3dc86d9a84b1897e632f8bfef8b56d370ba4ecca9299822ea8cc1ddb77',
     x86_64: '29a099cb2888bf28e14c9642d965efca7eab952eb0257247ea4ae0a0e8a8f38a'
  })

  depends_on 'glibc' # R

  cmake_options '-DLIBUV_BUILD_TESTS=OFF'
end
