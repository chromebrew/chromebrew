require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '18.1.2'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32103f845303cf9d9ef30f21d8f08e358916707f0f54b1d6e8a7e809b0de9337',
     armv7l: '32103f845303cf9d9ef30f21d8f08e358916707f0f54b1d6e8a7e809b0de9337',
       i686: 'c19025d665a5ca586bac261dd0ba6909167d92eeca504393f1c40347d5d7ac2b',
     x86_64: 'cd2321530ec2bca1884e79cb12fd42c5c4009a91c507b338cd8dd6f3ac8d0590'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm18_dev' => :build
  depends_on 'llvm18_lib' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R

  # https://github.com/KhronosGroup/SPIRV-LLVM-Translator/issues/2635
  cmake_options "-DBUILD_SHARED_LIBS=ON -DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR=#{CREW_PREFIX}/include/spirv"
end
