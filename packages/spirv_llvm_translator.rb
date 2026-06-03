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
    aarch64: 'de1a3b93a04b4f641b4cd178a466194f2f48b863842f73d15fd6a1d596ad00f8',
     armv7l: 'de1a3b93a04b4f641b4cd178a466194f2f48b863842f73d15fd6a1d596ad00f8',
       i686: '978e00d4e541d7e773a17e48f51a0d5e348f9c91b015b2a205fae31f5a51af55',
     x86_64: '4f840ea90b8cbc10dd3ce053958c5aaf6db1cebb01cf8a3c46f9e9ed31cf53a1'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' => :library
  depends_on 'spirv_tools' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
