require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '23.1.3'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad44a13c13a2b7fc95286b5166ac5acba2728b09eed85b72fb8087dec15b4a50',
     armv7l: 'ad44a13c13a2b7fc95286b5166ac5acba2728b09eed85b72fb8087dec15b4a50',
       i686: '1da00c2b3925d50204c3377832d099116ccba6ccf62fabee3d1202d49a15ca88',
     x86_64: 'c9d2e2c5520b722fa0a7846b58f62f7ec4dd48724ff86c8ca5a072f388d466fd'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' => :library
  depends_on 'spirv_tools' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
