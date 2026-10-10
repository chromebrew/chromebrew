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
    aarch64: 'ce940f52573adef4041724ee16f5f9cb51d048d4bc371dd2471e602351abd6d6',
     armv7l: 'ce940f52573adef4041724ee16f5f9cb51d048d4bc371dd2471e602351abd6d6',
       i686: '468fc676963fbf70d21cd96028ebea47ada02c16927e75ea51ab782ddcfb65f2',
     x86_64: '8b4061ebabde4cd79f058322021d006b6b56e74054c444d229cac5c07c1ed0ee'
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
