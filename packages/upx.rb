# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.2.1'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d5a47f8723363bf28ca88c467af8eab474169e992f968a0639ee907ea82d4c3',
     armv7l: '4d5a47f8723363bf28ca88c467af8eab474169e992f968a0639ee907ea82d4c3',
       i686: '01079ebe5c6479c82c779a1fdeca5c99af4fb6a7dbc6fab80d60afc0209bd348',
     x86_64: '1ff79c1faa974e1f043b0f6920a67829da0609b04cc13d78453814ab788a30aa'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
