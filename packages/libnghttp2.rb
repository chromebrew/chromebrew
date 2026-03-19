require 'buildsystems/cmake'

class Libnghttp2 < CMake
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  version "1.68.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b97295173c77410c1f5a7786e2616d6bed487807598a733ee3a94fedacada1e',
     armv7l: '4b97295173c77410c1f5a7786e2616d6bed487807598a733ee3a94fedacada1e',
       i686: 'c065e449d1404225bdfa9e002bb269ff4d290a1088f5eb461a8a380f6d9c8653',
     x86_64: '730c1ad9ed3317ded8dfa36b0dfcca2b4528dc7d51871d8fe9e5bad292cf7014'
  })

  depends_on 'glibc' => :library
  depends_on 'jansson' => :build
  depends_on 'jemalloc' => :build
  depends_on 'libev' => :build
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :build

  cmake_options '-DENABLE_SHARED_LIB=ON \
      -DENABLE_LIB_ONLY=ON'
end
