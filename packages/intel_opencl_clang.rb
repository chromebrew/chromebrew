# Adapted from Arch Linux intel-opencl-clang PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/intel-opencl-clang/trunk/PKGBUILD

require 'buildsystems/cmake'
Package.load_package("#{__dir__}/llvm19_build.rb")

class Intel_opencl_clang < CMake
  description 'Wrapper library around clang that can compile OpenCL C kernels to SPIR-V modules'
  homepage 'https://github.com/intel/opencl-clang'
  version '19.1.0'
  license 'llvm'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/intel/opencl-clang.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f2aed9c42fe4f7eb03018ac5a547ad53327fdfa00bca3eec2552fe9b5c47af1',
     armv7l: '2f2aed9c42fe4f7eb03018ac5a547ad53327fdfa00bca3eec2552fe9b5c47af1',
     x86_64: '4f42c34a737a16ab24350da369989cc1e07f8fc51b9e6487e19f60df228dbf21'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm19_dev' # R
  depends_on 'llvm19_lib' # R
  depends_on 'spirv_llvm_translator' # R

  cmake_options "-DPREFERRED_LLVM_VERSION=#{Llvm19_build.version} -DLLVM_DIR=#{CREW_LIB_PREFIX}/cmake/llvm"
end
