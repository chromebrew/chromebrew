require 'buildsystems/cmake'

class Libuv < CMake
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'https://libuv.org/'
  version '1.51.0'
  license 'BSD, BSD-2, ISC and MIT'
  compatibility 'all'
  source_url "https://dist.libuv.org/dist/v#{version}/libuv-v#{version}.tar.gz"
  source_sha256 '5f0557b90b1106de71951a3c3931de5e0430d78da1d9a10287ebc7a3f78ef8eb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e0424488bead5c05c6b01e73801417da431ef84aff201b137b2b0f46945b514',
     armv7l: '0e0424488bead5c05c6b01e73801417da431ef84aff201b137b2b0f46945b514',
       i686: 'e330145409fa893b9d2c3fb47d009a7396dd3495eceec8e3516be64c93330680',
     x86_64: 'beede27d456e1825e3cdbba560b9c49b8cd1778f8d25ef17205a467ed9b0b0ea'
  })

  depends_on 'glibc' # R

  cmake_options '-DLIBUV_BUILD_TESTS=OFF'
end
