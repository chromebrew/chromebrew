require 'buildsystems/cmake'

class Libuv < CMake
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'https://libuv.org/'
  version '1.52.0'
  license 'BSD, BSD-2, ISC and MIT'
  compatibility 'all'
  source_url "https://dist.libuv.org/dist/v#{version}/libuv-v#{version}.tar.gz"
  source_sha256 '19fd091a582c39c7ea26dcbb40a7d2e7cf095b070a757b3c32c05de6cfed6638'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a014c97f5ea4879140f775816006948717a75637ce9db89d0151eb6a0dfe975d',
     armv7l: 'a014c97f5ea4879140f775816006948717a75637ce9db89d0151eb6a0dfe975d',
       i686: 'cf4335ce9e5fbf2f48e23408b90461c1f1641a74fee161259a8be4751c467d37',
     x86_64: 'ca9e9928d3ea32b747fdb6b7a1c2cc0251fe078e221532f55c4cbedb3f926819'
  })

  depends_on 'glibc' # R

  cmake_options '-DLIBUV_BUILD_TESTS=OFF'
end
