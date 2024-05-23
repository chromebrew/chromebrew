# Adapted from Arch Linux spirv-llvm-translator PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/spirv-llvm-translator/trunk/PKGBUILD

require 'buildsystems/cmake'

class Spirv_llvm_translator < CMake
  description 'Tool and a library for bi-directional translation between SPIR-V and LLVM IR'
  homepage 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator'
  @_ver = '18.1.0'
  version "#{@_ver}-gcc14"
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '314bbf245fb76336bb506e23a5f7dfa7a605d2f346e1e578d24c0946a0571538',
     armv7l: '314bbf245fb76336bb506e23a5f7dfa7a605d2f346e1e578d24c0946a0571538',
     x86_64: '595cbecb0276f45f4f45e9a8cf33d48f5dc272ecf05b80a636feccdfaea4d444'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm18_dev' => :build
  depends_on 'llvm18_lib' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R
end
