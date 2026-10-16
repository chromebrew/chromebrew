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
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68ef045f13b2ccf5ca94ad9b77e7894572205245c5ff4f72b9f18d8ea89b1dec',
     armv7l: '68ef045f13b2ccf5ca94ad9b77e7894572205245c5ff4f72b9f18d8ea89b1dec',
       i686: '97a34288bd5c492e16e84ad57dc9c312d19621a729c69f517f9fe55b5ded1139',
     x86_64: '1030e224f3feb4c6adeee82b60ed3b3cd6eac25cca86b0dd3f485827d12d27f2'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DWITH_GTEST=OFF \
    -DINSTALL_UTILS=ON \
    -DZLIB_ENABLE_TESTS=OFF \
    -DBUILD_TESTING=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
