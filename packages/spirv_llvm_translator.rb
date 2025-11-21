require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '21.1.2'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dcf4b5def7038fa08031f3af05e72807f1c3703a4c0bf34b1fc8ba14039d40be',
     armv7l: 'dcf4b5def7038fa08031f3af05e72807f1c3703a4c0bf34b1fc8ba14039d40be',
       i686: 'b4c3b4f3152977005fd887c7cbf64ef1e774f6b315a5a111a48975aaeaa2b4ae',
     x86_64: '51542942fe1198aab5bb3a284470aa6510e9b6d10fbf6560a911e2982a7865b3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
