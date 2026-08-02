require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '22.1.5'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1f397bea3e5d1e175ce1fded9b382c6e1c1158cca6956274d8fbfaabed1b0dc5',
     armv7l: '1f397bea3e5d1e175ce1fded9b382c6e1c1158cca6956274d8fbfaabed1b0dc5',
       i686: '3ba3aa3d571213c5dd85f6ae5336f9d26f218579dc4f9c6ed13efe95b02ad048',
     x86_64: 'bfb8f8c07269710c9e6842b3bfc222567b1efd33773260e0a48a6acc3f4d94cc'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' => :library
  depends_on 'spirv_tools' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
