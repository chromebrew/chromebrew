require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '18.1.2-1'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4250cbcac0405cedea23f7dd69a39c91b3eeecc5cc9ef777f5bbdb41321e2eb0',
     armv7l: '4250cbcac0405cedea23f7dd69a39c91b3eeecc5cc9ef777f5bbdb41321e2eb0',
       i686: '1f1d987b287a8f9e2c35b4ecb8b96892cef4430c150bbb2132e1494496f97f5a',
     x86_64: '6e02404af1c28cbbdf4d6e2562790814c2ba6bfd2c8a0c38cd134e92f591b74b'
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
