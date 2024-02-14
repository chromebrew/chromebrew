# Adapted from Arch Linux vc-intrinsics PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/vc-intrinsics/trunk/PKGBUILD

require 'buildsystems/cmake'

class Vc_intrinsics < CMake
  description 'Set of new intrinsics on top of core LLVM IR instructions that represent SIMD semantics of a program targeting GPU'
  homepage 'https://github.com/intel/vc-intrinsics'
  version '0.17.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/intel/vc-intrinsics.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '774dec7bc0305d184895ca67978b6b5e2032e4bcf680b46a2bc096f3d6e857f9',
     armv7l: '774dec7bc0305d184895ca67978b6b5e2032e4bcf680b46a2bc096f3d6e857f9',
     x86_64: 'f5609153af13fe159c6aa7bf1fa2bcdaebbe9e7fa63de0ee93252a8433db0c21'
  })

  depends_on 'llvm17_dev' => :build

  cmake_options "-DLLVM_DIR=#{CREW_LIB_PREFIX}/cmake/llvm"
end
