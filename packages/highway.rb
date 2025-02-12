# Adapted from Arch Linux highway PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/highway/trunk/PKGBUILD

require 'buildsystems/cmake'

class Highway < CMake
  description 'A C++ library for SIMD Single Instruction, Multiple Data'
  homepage 'https://github.com/google/highway/'
  version '1.2.0'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/google/highway.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce08cdaa2edb56d438ddadd439dad0aad7cc81b75e79507970355a00d1299d08',
     armv7l: 'ce08cdaa2edb56d438ddadd439dad0aad7cc81b75e79507970355a00d1299d08',
       i686: '5e1a6569a998947c2c93729e27ca62524719ff82e2c37038f589c260d073034b',
     x86_64: 'aa0488630c6ddfbdbecdd43870568767f4bb99075f188285d4fb9d5af2caa6dd'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DBUILD_SHARED_LIBS:BOOL='ON' \
          -DHWY_ENABLE_TESTS:BOOL='OFF' \
          -DHWY_SYSTEM_GTEST:BOOL='OFF'"
end
