# Adapted from Arch Linux zlib-ng PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=zlib-ng

require 'buildsystems/cmake'

class Zlib_ng < CMake
  description 'zlib replacement with optimizations for next generation systems'
  homepage 'https://github.com/zlib-ng/zlib-ng'
  version '2.2.5'
  license 'Zlib'
  compatibility 'all'
  source_url 'https://github.com/zlib-ng/zlib-ng.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e6c7492e99d6be7e3833df41c126f8db5c8d76d4106cc757b3b19d5893c267a2',
     armv7l: 'e6c7492e99d6be7e3833df41c126f8db5c8d76d4106cc757b3b19d5893c267a2',
       i686: 'c65538e6450c3cdeb322fe7e450fde7668a501b2a4d3b02b1823371ff3f7d548',
     x86_64: '014b332e175cca9c4aae66b4c993a2a5d5c5f7031f1b0c8df5be98ea1d2a1abb'
  })

  depends_on 'glibc'

  cmake_options '-DWITH_GTEST=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
