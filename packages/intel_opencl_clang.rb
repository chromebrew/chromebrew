# Adapted from Arch Linux intel-opencl-clang PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/intel-opencl-clang/trunk/PKGBUILD

require 'buildsystems/cmake'

class Intel_opencl_clang < CMake
  description 'Wrapper library around clang that can compile OpenCL C kernels to SPIR-V modules'
  homepage 'https://github.com/intel/opencl-clang'
  version '17.0.0'
  license 'llvm'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/intel/opencl-clang.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a3849c0054664f1a55b424470a44f0b752426c4d97d3b2fbbd87cd598a25fc2',
     armv7l: '4a3849c0054664f1a55b424470a44f0b752426c4d97d3b2fbbd87cd598a25fc2',
     x86_64: '3e9bf8dc7e7da207b99f157bfc2da6895fd9b7114336feb1a8b65b3e065fbcf4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm17_dev' # R
  depends_on 'llvm17_lib' # R
  depends_on 'spirv_llvm_translator' => :build

  cmake_options "-DPREFERRED_LLVM_VERSION='17' -DLLVM_DIR=#{CREW_LIB_PREFIX}/cmake/llvm"
end
