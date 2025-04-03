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
    aarch64: '4849fd644b3ef7840943ea9f85825cb7ef0654abe566d01a9537738d121f9334',
     armv7l: '4849fd644b3ef7840943ea9f85825cb7ef0654abe566d01a9537738d121f9334',
       i686: '87723056d31693ac4c857584c92465e5511bfef69eb8d29fed33326c7e500592',
     x86_64: 'de6e5a4707db2ec9c5c8220b15527cde3b3711b117a25b6aeab4d257ae592706'
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
