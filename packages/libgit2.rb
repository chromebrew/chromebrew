require 'buildsystems/cmake'

class Libgit2 < CMake
  description 'A portable, pure C implementation of the Git core methods'
  homepage 'https://libgit2.org/'
  version '1.9.1'
  license 'GPL-2-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/libgit2/libgit2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '327f0cf21d1b2e635ad19401b7f4744e6b0c6824494dea5230cf6feaf14e7694',
     armv7l: '327f0cf21d1b2e635ad19401b7f4744e6b0c6824494dea5230cf6feaf14e7694',
       i686: 'b5f6116bb8c88ed1e8d434d02d5360568151e52dda83287969e128fc4d1c702c',
     x86_64: 'd7dfb26737ce9f4d971a3cab7809ed9124f4b65cb68444c467f084ea0e283a85'
  })

  depends_on 'glibc' # R
  depends_on 'libssh2' # R
  depends_on 'openssl' # R
  depends_on 'pcre' # R
  depends_on 'python3' # L
  depends_on 'zlib' # R

  cmake_options '-DUSE_SSH=ON -DUSE_BUNDLED_ZLIB=OFF'
  # Tests #3 and #8 fail in containers
end
