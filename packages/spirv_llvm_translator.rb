require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '22.1.4'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd763f1776c122c77ea5d15ad39be744242d1455385aedd2ecc99b9a80e6b0c34',
     armv7l: 'd763f1776c122c77ea5d15ad39be744242d1455385aedd2ecc99b9a80e6b0c34',
       i686: 'ef6a09d96b671a6d9261b8e7c9c60f265bd7b1b5a31217134082329d197fb405',
     x86_64: '821ab4e0c03478c51aef73df5db2f7f690f2c28d9f90639190667ca9f7699cdd'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' => :library
  depends_on 'spirv_tools' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
