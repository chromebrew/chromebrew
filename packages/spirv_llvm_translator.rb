require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '19.1.0'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94168306215da753753de559681523e026ddd7fe88c8cb6266d364bbbb4bf099',
     armv7l: '94168306215da753753de559681523e026ddd7fe88c8cb6266d364bbbb4bf099',
       i686: '1c5a9b9c4f48714f8794e85b9be11f6f2b53e54831554b5c5b85d23db356e857',
     x86_64: '527c8dc9eb24f172603c0ec3fa40b32d045c78f322d7ade1c4c17dfe51f4ebd2'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm19_dev' => :build
  depends_on 'llvm19_lib' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R

  # https://github.com/KhronosGroup/SPIRV-LLVM-Translator/issues/2635
  cmake_options "-DBUILD_SHARED_LIBS=ON -DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR=#{CREW_PREFIX}/include/spirv"
end
