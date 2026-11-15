# Adapted from Arch Linux intel-opencl-clang PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/intel-opencl-clang/trunk/PKGBUILD

require 'buildsystems/cmake'
Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_build.rb")

class Intel_opencl_clang < CMake
  description 'Wrapper library around clang that can compile OpenCL C kernels to SPIR-V modules'
  homepage 'https://github.com/intel/opencl-clang'
  version '23.1.0'
  license 'llvm'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/intel/opencl-clang.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db11d584f0b80fee1ddd04ffbe716707e1617aa5e8998da6776937205d11272b',
     armv7l: 'db11d584f0b80fee1ddd04ffbe716707e1617aa5e8998da6776937205d11272b',
     x86_64: 'fe2fe6331b7b0c9dddad299a633f9e7907f7d0e847f5899a22af436beced9a76'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :library
  depends_on 'llvm_lib' => :library
  depends_on 'spirv_llvm_translator' => :library

  cmake_options "-DPREFERRED_LLVM_VERSION=#{`clang -dumpversion`.chomp.sub(/\.\d+$/, '')} -DLLVM_DIR=#{CREW_LIB_PREFIX}/cmake/llvm"
end
