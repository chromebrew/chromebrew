require 'buildsystems/cmake'

class Libnghttp2 < CMake
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  version "1.68.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e50e50473ae3de629ac6dc0dd09f497dee584be58afc7416f72f5e8abbcccb3b',
     armv7l: 'e50e50473ae3de629ac6dc0dd09f497dee584be58afc7416f72f5e8abbcccb3b',
       i686: 'e52961bb6e9114f38ce2530f826889ba8c597c220bfe7010d29a34c01fd7e9ce',
     x86_64: 'd870b2421da67b52b0d8d9e9c50edff65636f34e022d95e6fa583a79b4c14850'
  })

  depends_on 'glibc' # R
  depends_on 'jansson' => :build
  depends_on 'jemalloc' => :build
  depends_on 'libev' => :build
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :build

  cmake_options '-DENABLE_SHARED_LIB=ON \
      -DENABLE_LIB_ONLY=ON'
end
