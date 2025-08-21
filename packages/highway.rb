# Adapted from Arch Linux highway PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/highway/trunk/PKGBUILD

require 'buildsystems/cmake'

class Highway < CMake
  description 'A C++ library for SIMD Single Instruction, Multiple Data'
  homepage 'https://github.com/google/highway/'
  version '1.3.0'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/google/highway.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a4506be917245b76a7ea57b6583b8e84abdb895568d810aa083befbb1c28d29',
     armv7l: '0a4506be917245b76a7ea57b6583b8e84abdb895568d810aa083befbb1c28d29',
       i686: 'cd42aaf8dd86bb361adbb789780aa09c8d28accd67a83ca631574362f7be35fd',
     x86_64: 'a2ccf7026366309d8b9461fb426c27c778d6cd1c10dcda2e543310176ee201e0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DBUILD_SHARED_LIBS:BOOL='ON' \
          -DHWY_ENABLE_TESTS:BOOL='ON' \
          -DHWY_SYSTEM_GTEST:BOOL='OFF'"
end
