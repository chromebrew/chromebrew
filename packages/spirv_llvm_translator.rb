# Adapted from Arch Linux spirv-llvm-translator PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/spirv-llvm-translator/trunk/PKGBUILD

require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  version '18.1.0'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09ffe51c28f2839522c74bc1180d7a8b6862f3e360ae1736ddb4f8601311f5e5',
     armv7l: '09ffe51c28f2839522c74bc1180d7a8b6862f3e360ae1736ddb4f8601311f5e5',
     x86_64: '89bfa4e3cbb0fc50aba0024932ce6345b08e57b5dc90fd9b85d9e0c3dc172648'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm18_dev' => :build
  depends_on 'llvm18_lib' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R
end
