# Adapted from Arch Linux zlib-ng PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=zlib-ng

require 'buildsystems/cmake'

class Zlib_ng < CMake
  description 'zlib replacement with optimizations for next generation systems'
  homepage 'https://github.com/zlib-ng/zlib-ng'
  version '2.3.3'
  license 'Zlib'
  compatibility 'all'
  source_url 'https://github.com/zlib-ng/zlib-ng.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5858397904fa16e8e31698015cd1a76780ac2ee79274dc1923ffbcfaa842f8b9',
     armv7l: '5858397904fa16e8e31698015cd1a76780ac2ee79274dc1923ffbcfaa842f8b9',
       i686: '4e2cc72228e0b29630df6d7e181262528e323f4cc3de1461d47fae168bfc0cd6',
     x86_64: 'd5c15197063e01ac52cfcc13d00c2114f6a52a21ee202072def770ff29b40d34'
  })

  depends_on 'glibc' # R

  cmake_options '-DWITH_GTEST=OFF \
    -DZLIB_ENABLE_TESTS=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
