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
    aarch64: '9f46463c79de5a225f6ce1710fb2d63ec9abd99139478b244d84864965727596',
     armv7l: '9f46463c79de5a225f6ce1710fb2d63ec9abd99139478b244d84864965727596',
     x86_64: 'eb16a55db7aa5d9e080c1915f9f27db5cc66041f0ab67ce595461f1caf11cc0b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm18_dev' => :build
  depends_on 'llvm18_lib' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R
end
