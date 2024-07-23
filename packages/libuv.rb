require 'buildsystems/cmake'

class Libuv < CMake
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'https://libuv.org/'
  version '1.48.0'
  license 'BSD, BSD-2, ISC and MIT'
  compatibility 'all'
  source_url "https://dist.libuv.org/dist/v#{version}/libuv-v#{version}.tar.gz"
  source_sha256 '7f1db8ac368d89d1baf163bac1ea5fe5120697a73910c8ae6b2fffb3551d59fb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e0424488bead5c05c6b01e73801417da431ef84aff201b137b2b0f46945b514',
     armv7l: '0e0424488bead5c05c6b01e73801417da431ef84aff201b137b2b0f46945b514',
       i686: 'e330145409fa893b9d2c3fb47d009a7396dd3495eceec8e3516be64c93330680',
     x86_64: 'beede27d456e1825e3cdbba560b9c49b8cd1778f8d25ef17205a467ed9b0b0ea'
  })

  depends_on 'glibc' # R
end
