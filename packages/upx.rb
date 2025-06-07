# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.0.1-1'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bda7b57800d5230732a473e4e9708c6080e9813e15d088b3a5df87a39cb44aae',
     armv7l: 'bda7b57800d5230732a473e4e9708c6080e9813e15d088b3a5df87a39cb44aae',
       i686: 'fbe51da85491ff055499c2ad495995ff5d21699a1d25fc5b1acef30a3076faa8',
     x86_64: 'a3fce44c3e0e0793456d8e63b718c4d33e02dfececd23aed141e31d04077bac7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
