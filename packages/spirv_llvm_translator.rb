require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '23.1.0'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4f941a251e728d3bc09fa97cbbeddb86fee2b6d269438d42b1df19cd8b5d04e',
     armv7l: 'c4f941a251e728d3bc09fa97cbbeddb86fee2b6d269438d42b1df19cd8b5d04e',
       i686: '595f113ebbfcef1e0d7329003041968465c94aefb957c5d3a690b52369b9648b',
     x86_64: '4e20fc284b0660b4f14a09fbc9074d9fd9c9f4ceea4112fe70a3aac8b82aa8bb'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' => :library
  depends_on 'spirv_tools' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
