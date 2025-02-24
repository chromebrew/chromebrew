# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.0.0'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd33d8bf41db6e536dc9302b62bbeb47233ab6428f5c759d4c055612aaf7551b1',
     armv7l: 'd33d8bf41db6e536dc9302b62bbeb47233ab6428f5c759d4c055612aaf7551b1',
       i686: 'af902974d3e7194340e450f2377bab8b6f7e2078c65f8a6e6ff071a4f41d9ac2',
     x86_64: 'b7b9e5a160059e1ac1ea093ce7a2f2a977a6ca1eda656f96c011e42b2aa0e34f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
