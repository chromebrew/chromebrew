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
    aarch64: '1836b2103c51ae3a040cae982078373326c3e99bea9ebe69c05a9a37c01dd6be',
     armv7l: '1836b2103c51ae3a040cae982078373326c3e99bea9ebe69c05a9a37c01dd6be',
       i686: '49897ed248a55a8826d6fe0bfa3bc56511bbde818f9d2d1ca72040b21c9a9c05',
     x86_64: '3bec63e51203971e13f0e5da10ff2889db34698ba29848b30c7fbf92eba96ccd'
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
