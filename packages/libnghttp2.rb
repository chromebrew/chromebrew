require 'buildsystems/cmake'

class Libnghttp2 < CMake
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  version "1.65.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '195d30fa9d142ca5148f383f272813682e22e96542bd9b814929f4a6d93f09e7',
     armv7l: '195d30fa9d142ca5148f383f272813682e22e96542bd9b814929f4a6d93f09e7',
       i686: 'd18ece84eabe1331c6483171bd397a8d06aaf29e2dc82b73530936ac01855b04',
     x86_64: '1b66bb30fd1b078b9663d0006ec803f669b5334d0c7828bc73fd3e19dfee1256'
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
