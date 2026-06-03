require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '22.1.3'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b850cce6e35bf66eb09ce24d5caecf9b5370977d396c090117cc5ff489f05f24',
     armv7l: 'b850cce6e35bf66eb09ce24d5caecf9b5370977d396c090117cc5ff489f05f24',
       i686: '845fd618c01ad1e7fab61275eae4153dc9d00b2ae90c9b4cd87d87600b356360',
     x86_64: '46c6cb05b27de2101c33c91bd0934e01824285a6a7be2d76a23894060cea2b1a'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' => :library
  depends_on 'spirv_tools' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
