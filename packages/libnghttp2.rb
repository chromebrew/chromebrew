require 'buildsystems/cmake'

class Libnghttp2 < CMake
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  version "1.69.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17d8c4d349ada64bd5c65143de69a037c60d08a814fda698c6740366ac00680a',
     armv7l: '17d8c4d349ada64bd5c65143de69a037c60d08a814fda698c6740366ac00680a',
       i686: '074c826a2263b90a5fd7659047f08147bdd0ec990340bd66e19bdcd5cb5fb8ee',
     x86_64: 'e33dbc11baefc32b04f78e27a7d9f41209bf99da8352bd29a92ae0773073460b'
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
