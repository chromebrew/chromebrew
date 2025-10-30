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
    aarch64: '69170f13b5195a4de3f94fe4fe12c337cee652e1f793ffc5338826d7b7bafa08',
     armv7l: '69170f13b5195a4de3f94fe4fe12c337cee652e1f793ffc5338826d7b7bafa08',
       i686: 'f16f42eebd5e14096f7c3bc3e2bcf47d9f11a6ffa45441490672813f6de9e5eb',
     x86_64: 'f1e1fc9c9aa3f68cff3dafc876f17039ad2cec6048bc927341ac88645770a370'
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
