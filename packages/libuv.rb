require 'buildsystems/cmake'

class Libuv < CMake
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'https://libuv.org/'
  version '1.53.0'
  license 'BSD, BSD-2, ISC and MIT'
  compatibility 'all'
  source_url "https://dist.libuv.org/dist/v#{version}/libuv-v#{version}.tar.gz"
  source_sha256 'cb0d6dd2128d5a95bd242c6cc982a24fe608fa93da57b6b4ec763b0018c53e64'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'affb73b869f08429dc50057a294fc9015a3933d2dc18869ed43b6af8fbb3015d',
     armv7l: 'affb73b869f08429dc50057a294fc9015a3933d2dc18869ed43b6af8fbb3015d',
       i686: '0adc2dd79e76df104ab9fa67ab5ddea5d07155c8cd38a43eb815dda22d8337fe',
     x86_64: 'ae6fddbbf8a46fa99beb06650293e44a980e90c8196ca7bb7097b19f391db8f2'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DLIBUV_BUILD_TESTS=OFF'
end
