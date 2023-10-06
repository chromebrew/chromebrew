require 'buildsystems/cmake'

class Libnghttp2 < CMake
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  @_ver = '1.56.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.56.0-py3.12_armv7l/libnghttp2-1.56.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.56.0-py3.12_armv7l/libnghttp2-1.56.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.56.0-py3.12_i686/libnghttp2-1.56.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.56.0-py3.12_x86_64/libnghttp2-1.56.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fda02efa2fb3c4e0e9fe57bec96111a49f716718737b1be9aa7461c5ee829035',
     armv7l: 'fda02efa2fb3c4e0e9fe57bec96111a49f716718737b1be9aa7461c5ee829035',
       i686: '9e52b30c85ff5d06070c58c168519722f42538a896cfdf7baf8e8975a6626ca4',
     x86_64: 'ba6bc4a6f2fb3443410076df3e21c83021537c09d1c07ffb53e91fb6f282986a'
  })

  depends_on 'glibc' # R
  depends_on 'jansson'
  depends_on 'jemalloc'
  depends_on 'libev' => :build
  depends_on 'openssl' # R
  depends_on 'python3' => :build
  depends_on 'py3_cython' => :build

  cmake_options '-DENABLE_SHARED_LIB=ON \
      -DENABLE_LIB_ONLY=ON'
end
