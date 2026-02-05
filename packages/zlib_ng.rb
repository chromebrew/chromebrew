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
    aarch64: '92348376191cb1662d60b1fe7d05ae4e09c6f69936f9bc60060c0bd48c406b90',
     armv7l: '92348376191cb1662d60b1fe7d05ae4e09c6f69936f9bc60060c0bd48c406b90',
       i686: '6b4155108b9cb59651b598ef903c410e0ddbe170023c4d045fa795e1ebfce9c6',
     x86_64: 'a135ccac1853ebdd1f5f68d6f60b3ecf06cb822448114e0f669d732cd4592cd2'
  })

  depends_on 'glibc'

  cmake_options '-DWITH_GTEST=OFF \
    -DZLIB_ENABLE_TESTS=OFF \
    -DBUILD_SHARED_LIBS=ON'
end
