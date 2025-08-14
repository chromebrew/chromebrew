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
    aarch64: '6f70e2c3a18e809cfc0bd92059170e9ae938416847e2c91b2549800fc6e2c387',
     armv7l: '6f70e2c3a18e809cfc0bd92059170e9ae938416847e2c91b2549800fc6e2c387',
       i686: '67cc7fbd92642298fc6bca2a20c50f648095a42482b5ebe7a0e02657a238a317',
     x86_64: 'baf51c97c8244097c847dcd5645d21feb65631b20e1cc3fb70c24455bacaf0c3'
  })

  depends_on 'glibc'

  cmake_options '-DWITH_GTEST=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
