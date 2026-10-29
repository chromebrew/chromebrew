# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.3.0'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1f33da39953136656faf2437a7964c3acd131aad4868662e72cec4bc8d51a9a',
     armv7l: 'c1f33da39953136656faf2437a7964c3acd131aad4868662e72cec4bc8d51a9a',
       i686: '2d328d9f8bde39fe4c61de42cd5b5ccdb13e00a9540d73a34f55f35beb9060c1',
     x86_64: 'e75f8636971c3d95880d53a4b4607d1b38f75f4ccfac03264a9bc19064c23484'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
