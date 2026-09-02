require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '23.1.1'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '119e5796c7c2142b96e53968eca13c8975d4985973673e95820536ddf1070791',
     armv7l: '119e5796c7c2142b96e53968eca13c8975d4985973673e95820536ddf1070791',
       i686: '9f09e541fda0d91a513ad0ae7105d195cab26ed3c0276a3f3e3f634ffd8864eb',
     x86_64: 'ea20158d5c2456084af4e6ff56145f5f1844cfe9f1752f651035135cea83d498'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' => :library
  depends_on 'spirv_tools' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
