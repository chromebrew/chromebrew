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
    aarch64: 'cf2f510bb35f5e84766041262e516b4af07143e5251018ca477a4b8e3c07e2d0',
     armv7l: 'cf2f510bb35f5e84766041262e516b4af07143e5251018ca477a4b8e3c07e2d0',
       i686: '2fd63b9abfd4b729dd9d88d800d409f71407a89a4aca68109ec3dc873903b91f',
     x86_64: 'cde6053aa43220780269a00920e555d1665b3dd72b724877ba58191bf4799933'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options "-DBUILD_SHARED_LIBS:BOOL='ON' \
          -DHWY_ENABLE_TESTS:BOOL='ON' \
          -DHWY_SYSTEM_GTEST:BOOL='OFF'"
end
