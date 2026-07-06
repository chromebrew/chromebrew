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
    aarch64: '68210bbe3af6a980ab01757f1ecde1eb1f3c36f929f56acd36c8936fdb133ed9',
     armv7l: '68210bbe3af6a980ab01757f1ecde1eb1f3c36f929f56acd36c8936fdb133ed9',
       i686: '4a6a096da50dc1632d2cc1d0a10bc938337cc893ec7ba7dd533193cf42412876',
     x86_64: '5bd5b5786fc9ed1029a5bd55ed52277b6b1b7972f56b2b11b27d6bb159df311c'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DLIBUV_BUILD_TESTS=OFF'
end
