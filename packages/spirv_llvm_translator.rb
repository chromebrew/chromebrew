require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '20.1.1'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f850a2e7d975b96c498f973d3865d820ab526c1c38026a68d6a545eaa49e8571',
     armv7l: 'f850a2e7d975b96c498f973d3865d820ab526c1c38026a68d6a545eaa49e8571',
       i686: 'bfd10c69c6f8e4d378411c0a0ea36fbdb9fc3189b109c70a7cbf2ba07cee59c5',
     x86_64: '76ef851432e568d2b0a3ee42cefb2d74ea3fb9aa2b9b20f9fa8ce6053b10f967'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
