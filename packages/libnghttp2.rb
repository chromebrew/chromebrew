require 'buildsystems/cmake'

class Libnghttp2 < CMake
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  version "1.70.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9747090ef9bf401b02b05581c6160973a4305c5750f1ab9b2ffe99371f933e1',
     armv7l: 'c9747090ef9bf401b02b05581c6160973a4305c5750f1ab9b2ffe99371f933e1',
       i686: 'ac59e304ed2c8775b23615e023ae7a1575bd67ebefcc761ea9f7e62f9af2e5cd',
     x86_64: '0a0bc6a88bd3579cdfa8fcdfe3911e361c86a82566fa41ba5d99cc0e399d42ec'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jansson' => :build
  depends_on 'jemalloc' => :build
  depends_on 'libev' => :build
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :build

  cmake_options '-DENABLE_SHARED_LIB=ON \
      -DENABLE_LIB_ONLY=ON'
end
