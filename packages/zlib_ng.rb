# Adapted from Arch Linux zlib-ng PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=zlib-ng

require 'buildsystems/cmake'

class Zlib_ng < CMake
  description 'zlib replacement with optimizations for next generation systems'
  homepage 'https://github.com/zlib-ng/zlib-ng'
  version '2.2.4'
  license 'Zlib'
  compatibility 'all'
  source_url 'https://github.com/zlib-ng/zlib-ng.git'
  git_hashtag version
  binary_compression 'tar.zst'

  depends_on 'glibc'

  cmake_options '-DWITH_GTEST=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
