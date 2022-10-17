require 'buildsystems/cmake/v1'

class Libgit2 < Cmake_v1
  description 'A portable, pure C implementation of the Git core methods'
  homepage 'https://libgit2.org/'
  @_ver = '1.5.0'
  version @_ver
  license 'GPL-2-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/libgit2/libgit2.git'
  git_hashtag "v#{@_ver}"

  depends_on 'python3'
  depends_on 'libssh2'

  cmake_options "-DBUILD_CLI=ON \
                 -DBUILD_EXAMPLE=ON \
                 -DBUILD_TESTS=ON \
                 -DUSE_BUNDLED_ZLIB=OFF \
                 -DUSE_SSH=ON"
  check? false
end
