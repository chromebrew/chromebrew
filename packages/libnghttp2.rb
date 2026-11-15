require 'buildsystems/cmake'

class Libnghttp2 < CMake
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  version "1.71.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7b878398c26dd4a63e7adf3f0192fa6af029d21e142461e0230327c0e7f39805',
     armv7l: '7b878398c26dd4a63e7adf3f0192fa6af029d21e142461e0230327c0e7f39805',
       i686: '2870c80a63f1f49e4b05475da510447fe49ef6fc353f41365bd425b664cb034e',
     x86_64: 'b2782668d333deb1d3076ed3d12fbd1d5b8f54b65aa2162d334811020f23f058'
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
