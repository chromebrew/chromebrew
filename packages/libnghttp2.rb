require 'buildsystems/cmake'

class Libnghttp2 < CMake
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  @_ver = '1.58.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.58.0-py3.12_armv7l/libnghttp2-1.58.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.58.0-py3.12_armv7l/libnghttp2-1.58.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.58.0-py3.12_i686/libnghttp2-1.58.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.58.0-py3.12_x86_64/libnghttp2-1.58.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3d71393f9447a4cba71c42766ea5f53b97f9eda232103feb1066c3cf94443b50',
     armv7l: '3d71393f9447a4cba71c42766ea5f53b97f9eda232103feb1066c3cf94443b50',
       i686: 'b9b4d51de06704610900f74811a2132779ae629bfccc5c3b6d89edf913dd817d',
     x86_64: '1637c2318a5ea05f958c32be7cbc9bead3df2b167f8eaaab78bd89b16929288a'
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
