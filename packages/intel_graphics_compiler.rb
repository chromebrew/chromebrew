# Adapted from Arch Linux intel-graphics-compiler PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/intel-graphics-compiler/trunk/PKGBUILD

require 'buildsystems/cmake'

class Intel_graphics_compiler < CMake
  description 'Intel Graphics Compiler for OpenCL'
  homepage 'https://github.com/intel/intel-graphics-compiler'
  version '1.0.15770.14'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/intel/intel-graphics-compiler.git'
  git_hashtag "igc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'ef7123c5dcfdd0cfc9bb85b8025fb82302af744ea2201babb2d01b5c9c6d6866'
  })

  depends_on 'intel_opencl_clang' => :build
  depends_on 'libunwind' => :build
  depends_on 'llvm17_dev' => :build
  depends_on 'llvm17_lib' => :build
  depends_on 'ncurses' => :build
  depends_on 'protobuf' => :build
  depends_on 'py3_mako' => :build
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' => :build
  depends_on 'vc_intrinsics' => :build

  def self.prebuild
    system 'git clone https://github.com/intel/vc-intrinsics ../vc-intrinsics'
    system 'git clone https://github.com/KhronosGroup/SPIRV-Tools.git ../SPIRV-Tools'
    system 'git clone https://github.com/KhronosGroup/SPIRV-Headers.git ../SPIRV-Headers'
  end

  cmake_options "-DIGC_OPTION__LLVM_PREFERRED_VERSION='17' -DIGC_OPTION__LLVM_MODE=Prebuilds"
end
