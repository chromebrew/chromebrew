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
       i686: '45b041fb1f9f636dee1bb76bb111cc3fbea307f52c6b7080cfc1cd433ba526f3',
     x86_64: 'db88247a206e8c49bffb25977385cebbc1648fb25c3ce360e353a323f1125188'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DBUILD_SHARED_LIBS:BOOL='ON' \
          -DHWY_ENABLE_TESTS:BOOL='ON' \
          -DHWY_SYSTEM_GTEST:BOOL='OFF'"
end
