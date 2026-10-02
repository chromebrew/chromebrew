require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '23.1.2'
  license 'Apache-2.0 WITH LLVM-exception'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb1455b599d9496e68cff1f7394f52b54ee7a8149eaf916e3723cbff95dfd113',
     armv7l: 'eb1455b599d9496e68cff1f7394f52b54ee7a8149eaf916e3723cbff95dfd113',
       i686: 'a5314fe0720087827c3f7572eb0b425995ce5c1e42b750071d8e05a479861320',
     x86_64: '003e1d559e74dd428b61ee6a37c21c3ba9222f028157ab89fa8e527429466134'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'llvm_lib' => :library
  depends_on 'spirv_tools' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
