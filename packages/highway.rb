# Adapted from Arch Linux highway PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/highway/trunk/PKGBUILD

require 'buildsystems/cmake'

class Highway < CMake
  description 'A C++ library for SIMD Single Instruction, Multiple Data'
  homepage 'https://github.com/google/highway/'
  version '1.4.0'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/google/highway.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c007b93d078a4e8ba6a9f7ebfa065065a3167a548ba3f1564a62791f5e37afe8',
     armv7l: 'c007b93d078a4e8ba6a9f7ebfa065065a3167a548ba3f1564a62791f5e37afe8',
       i686: 'd9f55dcfef31f1aea0a97d86277cda36bc136ab608378f8ec9293674b6a00b7a',
     x86_64: '7fdc91f24c796df54a4ef45004f6aafa07b99f82c245f05569d22d59eb65e307'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options "-DBUILD_SHARED_LIBS:BOOL='ON' \
          -DHWY_ENABLE_TESTS:BOOL='ON' \
          -DHWY_SYSTEM_GTEST:BOOL='OFF'"
end
