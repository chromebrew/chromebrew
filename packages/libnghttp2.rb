require 'buildsystems/cmake'

class Libnghttp2 < CMake
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  @_ver = '1.59.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '670240eb03ba44d929c770cbf1f1d3c77f0b2c5ee1c8e1565afb1a4085a565e8',
     armv7l: '670240eb03ba44d929c770cbf1f1d3c77f0b2c5ee1c8e1565afb1a4085a565e8',
       i686: '6a8d411e25459774c9529276e8939ca8db1b6fe749d321b3bdbfd4d4d873bbea',
     x86_64: 'b40bd43b11403240b4c808877b70a04cba8c9fa1fc2a8a1f0e5f05d515cae21c'
  })

  depends_on 'glibc' # R
  depends_on 'jansson' => :build
  depends_on 'jemalloc' => :build
  depends_on 'libev' => :build
  depends_on 'openssl' # R
  depends_on 'python3' => :build
  depends_on 'py3_cython' => :build

  cmake_options '-DENABLE_SHARED_LIB=ON \
      -DENABLE_LIB_ONLY=ON'
end
