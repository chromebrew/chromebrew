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
    aarch64: '8959518b1562f848e986e1f0db8ec92580e87872b86543800b277edf03996288',
     armv7l: '8959518b1562f848e986e1f0db8ec92580e87872b86543800b277edf03996288',
       i686: 'aee6b6bdfeedb4ad8a8dabb08ad4be262a7df9c229ad8cb0beceab33d0db2667',
     x86_64: 'e5c9a14938e36cd97cde406776e75bab33da6057cb468128d5f1f1b3deb02209'
  })

  depends_on 'glibc' # R

  cmake_options '-DLIBUV_BUILD_TESTS=OFF'
end
