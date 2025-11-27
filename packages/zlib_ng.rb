# Adapted from Arch Linux zlib-ng PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=zlib-ng

require 'buildsystems/cmake'

class Zlib_ng < CMake
  description 'zlib replacement with optimizations for next generation systems'
  homepage 'https://github.com/zlib-ng/zlib-ng'
  version '2.3.1'
  license 'Zlib'
  compatibility 'all'
  source_url 'https://github.com/zlib-ng/zlib-ng.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba57b6eaa67ca7dcc7276090c9e653e958f8695ec4447edf5943bce33791911e',
     armv7l: 'ba57b6eaa67ca7dcc7276090c9e653e958f8695ec4447edf5943bce33791911e',
       i686: '7412f13677c8d92a43cb4c4cac85ed7f4705bfa907be0c44659edf3556c91fa5',
     x86_64: 'a97e2f2358162cd057b28c1d97fd5ff7f1548d3473b91857d57595cf5dec2a0a'
  })

  depends_on 'glibc'

  cmake_options '-DWITH_GTEST=OFF \
    -DZLIB_ENABLE_TESTS=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
