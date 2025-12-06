require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '21.1.3'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa8248f246042570db5023b013f7a3c9b3b5be25b42d029b57dc3cb5be941e32',
     armv7l: 'fa8248f246042570db5023b013f7a3c9b3b5be25b42d029b57dc3cb5be941e32',
       i686: 'd60088d15d068ab15c0046ec1e2c8d259a96805af696e96c5bb57c2f66076667',
     x86_64: '8296165e01b76986d1a34d54bfabdfba7407ebcf00f9ad1a631a88b1773ff448'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
