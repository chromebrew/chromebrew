require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '20.1.3'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3495b2e6c3897363829b5ffac8de2527c49ca4cd9a739c0966043eb0a52c9235',
     armv7l: '3495b2e6c3897363829b5ffac8de2527c49ca4cd9a739c0966043eb0a52c9235',
       i686: '66d45c590d1c9bcc707306af49e92675656878d419593dd6903af55efaf0e115',
     x86_64: '6c9ca8a32fd040373486e3cfada677d983547a697d5866185165ccbc33a57d88'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
