# Adapted from Arch Linux zlib-ng PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=zlib-ng

require 'buildsystems/cmake'

class Zlib_ng < CMake
  description 'zlib replacement with optimizations for next generation systems'
  homepage 'https://github.com/zlib-ng/zlib-ng'
  version '2.3.2'
  license 'Zlib'
  compatibility 'all'
  source_url 'https://github.com/zlib-ng/zlib-ng.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ee081560399cb3aa1821c44b0225dc18f25badf0ab7ab173ab87da550c4571e',
     armv7l: '0ee081560399cb3aa1821c44b0225dc18f25badf0ab7ab173ab87da550c4571e',
       i686: 'e1e932b270c43e8e6fe2b9f75d4a9cec41a285d88b33ca5ad67c7292187186ab',
     x86_64: '1f51b2bddc29bfb0be539ac946c217a098e533be1fe30e881f4c93e75f0b4aef'
  })

  depends_on 'glibc'

  cmake_options '-DWITH_GTEST=OFF \
    -DZLIB_ENABLE_TESTS=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
